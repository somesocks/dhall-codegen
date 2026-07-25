
let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

let Person =
  {
    appointment_time :
      {- RFC 3339 time -}
      Text,
    birth_date :
      {- ISO 8601 calendar date -}
      Text,
    created_at :
      {- RFC 3339 date-time -}
      Text,
    date_of_birth :
      {- date of birth -}
      Time,
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
    contact_email : Optional 
      {- contact email (we might not have this) -}
      Text
  }

in {
  Person
}