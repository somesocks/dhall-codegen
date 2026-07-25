import type { Person } from "./out";

const ada: Person = {
  appointment_time: "14:30:00.123",
  binary_data: "+/8=",
  birth_date: "1815-12-10",
  created_at: "1815-12-10T00:00:00Z",
  date_of_birth: new Date("1815-12-10T00:00:00Z"),
  friends: [
    {
      appointment_time: "09:00:00",
      binary_data: "+/8",
      birth_date: "1906-12-09",
      created_at: "1906-12-09T00:00:00Z",
      date_of_birth: new Date("1906-12-09T00:00:00Z"),
      friends: [],
      id: "123e4567-e89b-42d3-a456-426614174001",
      name: "Grace Hopper",
      phone_number: "+442079460123",
      retention_period: "P2W",
      source_ip: "198.51.100.2",
      destination_ip: "2001:db8::2",
      token: "-_8",
    },
  ],
  id: "123e4567-e89b-42d3-a456-426614174000",
  name: "Ada Lovelace",
  phone_number: "+14155552671",
  retention_period: "P1Y2M3DT4H5M6S",
  source_ip: "192.0.2.1",
  destination_ip: "2001:db8::1",
  token: "-_8=",
};

const email: string | undefined = ada.contact_email;
const friendNames: string[] = ada.friends.map((friend) => friend.name);

void email;
void friendNames;
