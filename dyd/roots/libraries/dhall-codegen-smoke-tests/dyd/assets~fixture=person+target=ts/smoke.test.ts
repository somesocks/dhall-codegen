import type { Person } from "./out";

const ada: Person = {
  appointment_time: "14:30:00.123+02:00",
  birth_date: "1815-12-10",
  created_at: "1815-12-10T00:00:00Z",
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
    },
  ],
  id: "123e4567-e89b-42d3-a456-426614174000",
  name: "Ada Lovelace",
  retention_period: "P1Y2M3DT4H5M6S",
};

const email: string | undefined = ada.contact_email;
const friendNames: string[] = ada.friends.map((friend) => friend.name);

void email;
void friendNames;
