import assert from "node:assert/strict";
import { readFileSync } from "node:fs";

import Ajv from "ajv";
import addFormats from "ajv-formats";

const schema = JSON.parse(readFileSync(new URL("./out.json", import.meta.url), "utf8"));
const ajv = new Ajv({ allErrors: true, strict: true });
addFormats(ajv);

assert.equal(ajv.validateSchema(schema), true, ajv.errorsText(ajv.errors));

const validatePerson = ajv.compile(schema);

const validPerson = {
  appointment_time: "14:30:00.123",
  binary_data: "+/8=",
  birth_date: "1815-12-10",
  contact: {
    email: "ada@example.com",
    phone_number: "+14155552671",
  },
  created_at: "2026-07-25T14:30:00.123+02:00",
  date_of_birth: "1815-12-10",
  friends: [
    {
      appointment_time: "09:00:00",
      binary_data: "+/8",
      birth_date: "1906-12-09",
      contact: {
        phone_number: "+442079460123",
      },
      created_at: "1906-12-09T00:00:00Z",
      date_of_birth: "1906-12-09",
      friends: [],
      id: "123e4567-e89b-42d3-a456-426614174001",
      name: "Grace Hopper",
      retention_period: "P2W",
      source_ip: "198.51.100.2",
      destination_ip: "2001:db8::2",
      token: "-_8",
    },
  ],
  id: "123e4567-e89b-42d3-a456-426614174000",
  name: "Ada Lovelace",
  retention_period: "P1Y2M3DT4H5M6S",
  source_ip: "192.0.2.1",
  destination_ip: "2001:db8::1",
  token: "-_8=",
};

assert.equal(validatePerson(validPerson), true, ajv.errorsText(validatePerson.errors));

for (const created_at of [
  "2026-07-25",
  "2026-07-25T14:30:00",
  "20260725T143000Z",
]) {
  assert.equal(validatePerson({ ...validPerson, created_at }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const birth_date of ["1815-12-10T00:00:00Z", "18151210", "1815-13-10"]) {
  assert.equal(validatePerson({ ...validPerson, birth_date }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const date_of_birth of ["1815-12-10T00:00:00Z", "18151210", "1815-13-10"]) {
  assert.equal(validatePerson({ ...validPerson, date_of_birth }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const appointment_time of ["14:30:00Z", "14:30:00+02:00", "143000", "24:00:00", "14:30:00\n"]) {
  assert.equal(validatePerson({ ...validPerson, appointment_time }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "pattern"), true);
}

for (const retention_period of ["P", "P1Y2MT", "1Y2M"]) {
  assert.equal(validatePerson({ ...validPerson, retention_period }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const id of ["not-a-uuid", "123e4567e89b42d3a456426614174000", "123e4567-e89b-42d3-a456-42661417400"]) {
  assert.equal(validatePerson({ ...validPerson, id }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const source_ip of ["999.0.0.1", "192.0.2", "2001:db8::1"]) {
  assert.equal(validatePerson({ ...validPerson, source_ip }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const destination_ip of ["2001:db8:::1", "192.0.2.1", "2001:db8"]) {
  assert.equal(validatePerson({ ...validPerson, destination_ip }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
}

for (const binary_data of ["YQ=", "Y", "YQ==\n"]) {
  assert.equal(validatePerson({ ...validPerson, binary_data }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "pattern"), true);
}

for (const token of ["+/8=", "YQ=", "Y"]) {
  assert.equal(validatePerson({ ...validPerson, token }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "pattern"), true);
}

for (const phone_number of ["14155552671", "+0", "+1 4155552671", "+1234567890123456"]) {
  assert.equal(validatePerson({ ...validPerson, contact: { ...validPerson.contact, phone_number } }), false);
  assert.equal(validatePerson.errors.some((error) => error.keyword === "pattern"), true);
}

const missingRequiredName = { ...validPerson };
delete missingRequiredName.name;
assert.equal(validatePerson(missingRequiredName), false);
assert.equal(validatePerson.errors.some((error) => error.keyword === "required"), true);

const invalidAdditionalProperty = { ...validPerson, nickname: "Ada" };
assert.equal(validatePerson(invalidAdditionalProperty), false);
assert.equal(
  validatePerson.errors.some((error) => error.keyword === "additionalProperties"),
  true,
);

const invalidFriend = {
  ...validPerson,
  friends: [{ ...validPerson.friends[0], contact: { ...validPerson.friends[0].contact, email: "not an email" } }],
};
assert.equal(validatePerson(invalidFriend), false);
assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
