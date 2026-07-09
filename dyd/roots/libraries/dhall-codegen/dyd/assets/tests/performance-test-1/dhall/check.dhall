let output = ./out.dhall.dhall

let expected = ./out.dhall as Text

let check = assert : output === expected

in  check
