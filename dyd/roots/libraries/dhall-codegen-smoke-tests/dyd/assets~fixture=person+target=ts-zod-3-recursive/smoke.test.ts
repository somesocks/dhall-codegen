import { Person } from "./out";
import type { TPerson } from "./out";

const ada: TPerson = {
  created_at: "2026-07-25T14:30:00.123+02:00",
  date_of_birth: new Date("1815-12-10T00:00:00Z"),
  friends: [
    {
      created_at: "1906-12-09T00:00:00Z",
      date_of_birth: new Date("1906-12-09T00:00:00Z"),
      friends: [],
      name: "Grace Hopper",
    },
  ],
  name: "Ada Lovelace",
};

const parsed: TPerson = Person.parse(ada);

if (parsed.friends[0]?.name !== "Grace Hopper") {
  throw new Error("failed to parse recursive person value");
}

const invalid = Person.safeParse({
  date_of_birth: new Date("1815-12-10T00:00:00Z"),
  friends: [],
  name: "Ada Lovelace",
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
