
let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

let Person =
  {
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