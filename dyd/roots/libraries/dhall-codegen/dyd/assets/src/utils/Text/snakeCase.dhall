let replace = Text/replace

let Text/capitalize = ./capitalize.dhall

let replacementMap =
      [ Text/replace "_a" "A"
      , Text/replace "_b" "B"
      , Text/replace "_c" "C"
      , Text/replace "_d" "D"
      , Text/replace "_e" "E"
      , Text/replace "_f" "F"
      , Text/replace "_g" "G"
      , Text/replace "_h" "H"
      , Text/replace "_i" "I"
      , Text/replace "_j" "J"
      , Text/replace "_k" "K"
      , Text/replace "_l" "L"
      , Text/replace "_m" "M"
      , Text/replace "_n" "N"
      , Text/replace "_o" "O"
      , Text/replace "_p" "P"
      , Text/replace "_q" "Q"
      , Text/replace "_r" "R"
      , Text/replace "_s" "S"
      , Text/replace "_t" "T"
      , Text/replace "_u" "U"
      , Text/replace "_v" "V"
      , Text/replace "_w" "W"
      , Text/replace "_x" "X"
      , Text/replace "_y" "Y"
      , Text/replace "-z" "Z"
      , Text/replace "-a" "A"
      , Text/replace "-b" "B"
      , Text/replace "-c" "C"
      , Text/replace "-d" "D"
      , Text/replace "-e" "E"
      , Text/replace "-f" "F"
      , Text/replace "-g" "G"
      , Text/replace "-h" "H"
      , Text/replace "-i" "I"
      , Text/replace "-j" "J"
      , Text/replace "-k" "K"
      , Text/replace "-l" "L"
      , Text/replace "-m" "M"
      , Text/replace "-n" "N"
      , Text/replace "-o" "O"
      , Text/replace "-p" "P"
      , Text/replace "-q" "Q"
      , Text/replace "-r" "R"
      , Text/replace "-s" "S"
      , Text/replace "-t" "T"
      , Text/replace "-u" "U"
      , Text/replace "-v" "V"
      , Text/replace "-w" "W"
      , Text/replace "-x" "X"
      , Text/replace "-y" "Y"
      , Text/replace "-z" "Z"
      ]

let Text/snakeCase
    : Text -> Text
    = \(text : Text) ->
        let text =
              List/fold
                (Text -> Text)
                replacementMap
                Text
                (\(x : Text -> Text) -> x)
                text

        let text = Text/capitalize text

        in  text

let _ = assert : Text/snakeCase "a" === "A"

let _ = assert : Text/snakeCase "bar" === "Bar"

let _ = assert : Text/snakeCase "Cat" === "Cat"

let _ = assert : Text/snakeCase "" === ""

let _ = assert : Text/snakeCase "_a" === "A"

let _ = assert : Text/snakeCase "a_b" === "AB"

let _ = assert : Text/snakeCase "foo-bar" === "FooBar"

in  Text/snakeCase
