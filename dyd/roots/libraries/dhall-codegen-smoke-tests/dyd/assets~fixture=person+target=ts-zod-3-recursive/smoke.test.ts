import { Person } from "./out";
import type { TPerson } from "./out";

const ada: TPerson = {
  appointment_time: "14:30:00.123+02:00",
  birth_date: "1815-12-10",
  created_at: "2026-07-25T14:30:00.123+02:00",
  date_of_birth: new Date("1815-12-10T00:00:00Z"),
  friends: [
    {
      appointment_time: "09:00:00Z",
      birth_date: "1906-12-09",
      created_at: "1906-12-09T00:00:00Z",
      date_of_birth: new Date("1906-12-09T00:00:00Z"),
      friends: [],
      id: "123e4567-e89b-42d3-a456-426614174001",
      name: "Grace Hopper",
      retention_period: "P2W",
      source_ip: "198.51.100.2",
    },
  ],
  id: "123e4567-e89b-42d3-a456-426614174000",
  name: "Ada Lovelace",
  retention_period: "P1Y2M3DT4H5M6S",
  source_ip: "192.0.2.1",
};

const parsed: TPerson = Person.parse(ada);

if (parsed.friends[0]?.name !== "Grace Hopper") {
  throw new Error("failed to parse recursive person value");
}

const invalid = Person.safeParse({
  ...ada,
  contact_email: "not an email address",
});

if (invalid.success) {
  throw new Error("expected invalid contact_email to fail validation");
}

for (const created_at of [
  "2026-07-25",
  "2026-07-25T14:30:00",
  "20260725T143000Z",
]) {
  if (Person.safeParse({ ...ada, created_at }).success) {
    throw new Error(`expected invalid created_at to fail validation: ${created_at}`);
  }
}

for (const birth_date of ["1815-12-10T00:00:00Z", "18151210", "1815-13-10"]) {
  if (Person.safeParse({ ...ada, birth_date }).success) {
    throw new Error(`expected invalid birth_date to fail validation: ${birth_date}`);
  }
}

for (const appointment_time of ["14:30:00", "143000Z", "24:00:00Z"]) {
  if (Person.safeParse({ ...ada, appointment_time }).success) {
    throw new Error(`expected invalid appointment_time to fail validation: ${appointment_time}`);
  }
}

for (const retention_period of ["P", "P1Y2MT", "1Y2M"]) {
  if (Person.safeParse({ ...ada, retention_period }).success) {
    throw new Error(`expected invalid retention_period to fail validation: ${retention_period}`);
  }
}

for (const id of ["not-a-uuid", "123e4567e89b42d3a456426614174000", "123e4567-e89b-42d3-a456-42661417400"]) {
  if (Person.safeParse({ ...ada, id }).success) {
    throw new Error(`expected invalid id to fail validation: ${id}`);
  }
}

for (const source_ip of ["999.0.0.1", "192.0.2", "2001:db8::1"]) {
  if (Person.safeParse({ ...ada, source_ip }).success) {
    throw new Error(`expected invalid source_ip to fail validation: ${source_ip}`);
  }
}
