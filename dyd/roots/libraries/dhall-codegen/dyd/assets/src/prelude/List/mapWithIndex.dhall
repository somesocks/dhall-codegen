--| Transform a list by applying a function to each element with its index
let List/map = ./map.dhall

let List/mapWithIndex
    : ∀(a : Type) → ∀(b : Type) → (Natural → a → b) → List a → List b
    = λ(a : Type) →
      λ(b : Type) →
      λ(f : Natural → a → b) →
      λ(xs : List a) →
        List/map
          { index : Natural, value : a }
          b
          (λ(i : { index : Natural, value : a }) → f i.index i.value)
          (List/indexed a xs)

in  List/mapWithIndex
