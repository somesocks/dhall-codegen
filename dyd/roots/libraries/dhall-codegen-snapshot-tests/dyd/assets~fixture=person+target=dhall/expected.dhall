
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
    name :
      {- full name -}
      Text,
    contact_email : Optional 
      {- contact email (we might not have this) -}
      Text
  }

in {
  Person
}