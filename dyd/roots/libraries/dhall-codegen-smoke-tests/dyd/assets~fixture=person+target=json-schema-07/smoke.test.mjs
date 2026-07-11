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
  date_of_birth: "1815-12-10T00:00:00Z",
  friends: [
    {
      date_of_birth: "1906-12-09T00:00:00Z",
      friends: [],
      name: "Grace Hopper",
    },
  ],
  name: "Ada Lovelace",
  contact_email: "ada@example.com",
};

assert.equal(validatePerson(validPerson), true, ajv.errorsText(validatePerson.errors));

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
  friends: [{ ...validPerson.friends[0], contact_email: "not an email" }],
};
assert.equal(validatePerson(invalidFriend), false);
assert.equal(validatePerson.errors.some((error) => error.keyword === "format"), true);
