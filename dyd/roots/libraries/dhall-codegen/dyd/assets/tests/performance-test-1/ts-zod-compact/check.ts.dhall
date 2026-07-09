let output = ./out.ts.dhall

let expected = ./out.ts as Text

let check = assert : output === expected

in  check
