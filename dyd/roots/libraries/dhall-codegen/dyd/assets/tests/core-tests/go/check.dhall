let output = ./out.go.dhall

let expected = ./out.go as Text

let check = assert : output === expected

in  check
