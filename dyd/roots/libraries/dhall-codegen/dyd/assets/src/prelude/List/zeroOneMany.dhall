let List/drop = ./drop.dhall

let List/tail
    : ∀(a : Type) → List a → List a
    = List/drop 1

let zeroOneMany
    : ∀(a : Type) → ∀(b : Type) → ({} → b) → (a → b) → (List a → b) → List a → b
    = λ(a : Type) →
      λ(b : Type) →
      λ(zero : {} → b) →
      λ(one : a → b) →
      λ(many : List a → b) →
      λ(list : List a) →
        merge
          { None = zero {=}
          , Some =
              λ(head : a) →
                let rest = List/tail a list

                in  merge
                      { None = one head, Some = λ(_ : a) → many list }
                      (List/head a rest)
          }
          (List/head a list)

let _ =
        assert
      :   zeroOneMany
            Natural
            Text
            (λ(_ : {}) → "zero")
            (λ(_ : Natural) → "one")
            (λ(_ : List Natural) → "many")
            ([] : List Natural)
        ≡ "zero"

let _ =
        assert
      :   zeroOneMany
            Natural
            Text
            (λ(_ : {}) → "zero")
            (λ(_ : Natural) → "one")
            (λ(_ : List Natural) → "many")
            ([ 0 ] : List Natural)
        ≡ "one"

let _ =
        assert
      :   zeroOneMany
            Natural
            Text
            (λ(_ : {}) → "zero")
            (λ(_ : Natural) → "one")
            (λ(_ : List Natural) → "many")
            ([ 0, 1 ] : List Natural)
        ≡ "many"

in  zeroOneMany
