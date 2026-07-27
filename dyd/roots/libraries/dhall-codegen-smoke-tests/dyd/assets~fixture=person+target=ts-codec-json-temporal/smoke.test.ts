import { Temporal } from "@js-temporal/polyfill";
import { CodecError, decodePerson, encodePerson } from "./out";
import type { Person } from "./out";

const ada: Person = {
  appointment_time: Temporal.PlainTime.from("14:30:00.123"),
  binary_data: "+/8=",
  birth_date: "1815-12-10",
  contact: {
    email: "ada@example.com",
    phone_number: "+14155552671",
  },
  created_at: "1815-12-10T00:00:00Z",
  date_of_birth: Temporal.PlainDate.from("1815-12-10"),
  friends: [],
  id: "123e4567-e89b-42d3-a456-426614174000",
  name: "Ada Lovelace",
  retention_period: Temporal.Duration.from("P1Y2M3DT4H5M6S"),
  source_ip: "192.0.2.1",
  destination_ip: "2001:db8::1",
  token: "-_8=",
};

const charles: Person = {
  ...ada,
  contact: {
    phone_number: "+14155552672",
  },
  friends: [],
  id: "123e4567-e89b-42d3-a456-426614174001",
  name: "Charles Babbage",
};

ada.friends.push(charles);

const encoded = encodePerson(ada);
const decoded = decodePerson(encoded);

if (decoded.name !== ada.name) throw new Error("name did not round-trip");
if (decoded.friends.length !== 1 || decoded.friends[0].name !== charles.name) {
  throw new Error("friend did not round-trip");
}
if (decoded.contact.email !== ada.contact.email) throw new Error("contact email did not round-trip");
if (decoded.friends[0].contact.email !== undefined) throw new Error("missing contact email did not round-trip");
if (Temporal.PlainTime.compare(decoded.appointment_time, ada.appointment_time) !== 0) {
  throw new Error("time did not round-trip");
}
if (Temporal.PlainDate.compare(decoded.date_of_birth, ada.date_of_birth) !== 0) {
  throw new Error("date did not round-trip");
}
if (Temporal.Duration.compare(decoded.retention_period, ada.retention_period) !== 0) {
  throw new Error("duration did not round-trip");
}

let rejected = false;
try {
  if (encoded === null || typeof encoded !== "object" || Array.isArray(encoded)) {
    throw new Error("person did not encode as an object");
  }
  decodePerson({ ...encoded, id: "not-a-uuid" });
} catch (error) {
  rejected = error instanceof CodecError;
}

if (!rejected) throw new Error("invalid UUID was accepted");
