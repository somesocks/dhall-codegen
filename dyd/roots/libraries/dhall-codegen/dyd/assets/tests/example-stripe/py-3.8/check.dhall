let output = ./out.py.dhall

let expected = ./out.py as Text

let check = assert : output === expected

in  check
