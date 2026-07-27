
let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

let PersonContact =
  {
    {- contact details -}
    phone_number :
      {- E.164 telephone number -}
      Text,
    email : Optional 
      {- contact email -}
      Text
  }

let Person =
  {
    appointment_time :
      {- ISO 8601 local time -}
      Time,
    binary_data :
      {- RFC 4648 Base64 -}
      Text,
    birth_date :
      {- ISO 8601 calendar date -}
      Text,
    contact :
      PersonContact,
    created_at :
      {- RFC 3339 date-time -}
      Text,
    date_of_birth :
      {- date of birth -}
      Date,
    destination_ip :
      {- IPv6 address -}
      Text,
    friends :
      (
        {- friends -}
        List
          Person
      ),
    id :
      {- RFC 4122 UUID -}
      Text,
    name :
      {- full name -}
      Text,
    retention_period :
      {- ISO 8601 duration -}
      Text,
    source_ip :
      {- IPv4 address -}
      Text,
    token :
      {- RFC 4648 Base64url -}
      Text
  }

in {
  PersonContact,
  Person
}