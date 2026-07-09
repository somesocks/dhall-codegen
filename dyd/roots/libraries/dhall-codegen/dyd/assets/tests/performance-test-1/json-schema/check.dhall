let output = ./out.json.dhall

let expected = ./out.json as Text

let check = assert : output === expected

in  check
