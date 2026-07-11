import type { Person } from "./out";

const ada: Person = {
  date_of_birth: new Date("1815-12-10T00:00:00Z"),
  friends: [
    {
      date_of_birth: new Date("1906-12-09T00:00:00Z"),
      friends: [],
      name: "Grace Hopper",
    },
  ],
  name: "Ada Lovelace",
};

const email: string | undefined = ada.contact_email;
const friendNames: string[] = ada.friends.map((friend) => friend.name);

void email;
void friendNames;
