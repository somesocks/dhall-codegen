--| Build a Text by copying the given Text the specified number of times
let concat = ./concat.dhall

let List/replicate = ../List/replicate.dhall

let replicate
    : Natural → Text → Text
    = λ(num : Natural) → λ(text : Text) → concat (List/replicate num Text text)

let example0 = assert : replicate 3 "foo" ≡ "foofoofoo"

let property = λ(text : Text) → assert : replicate 0 text ≡ ""

in  replicate
