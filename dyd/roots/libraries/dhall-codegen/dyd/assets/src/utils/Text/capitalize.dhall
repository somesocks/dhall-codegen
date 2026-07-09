let replace = Text/replace

let token = "w7l4PI0y4ANV3YoI"

let replacementMap =
      [ Text/replace token ""
      , Text/replace (token ++ "a") "A"
      , Text/replace (token ++ "b") "B"
      , Text/replace (token ++ "c") "C"
      , Text/replace (token ++ "d") "D"
      , Text/replace (token ++ "e") "E"
      , Text/replace (token ++ "f") "F"
      , Text/replace (token ++ "g") "G"
      , Text/replace (token ++ "h") "H"
      , Text/replace (token ++ "i") "I"
      , Text/replace (token ++ "j") "J"
      , Text/replace (token ++ "k") "K"
      , Text/replace (token ++ "l") "L"
      , Text/replace (token ++ "m") "M"
      , Text/replace (token ++ "n") "N"
      , Text/replace (token ++ "o") "O"
      , Text/replace (token ++ "p") "P"
      , Text/replace (token ++ "q") "Q"
      , Text/replace (token ++ "r") "R"
      , Text/replace (token ++ "s") "S"
      , Text/replace (token ++ "t") "T"
      , Text/replace (token ++ "u") "U"
      , Text/replace (token ++ "v") "V"
      , Text/replace (token ++ "w") "W"
      , Text/replace (token ++ "x") "X"
      , Text/replace (token ++ "y") "Y"
      , Text/replace (token ++ "z") "Z"
      ]

let Text/capitalize
    : Text -> Text
    = \(text : Text) ->
        List/fold
          (Text -> Text)
          replacementMap
          Text
          (\(x : Text -> Text) -> x)
          (token ++ text)

let _ = assert : Text/capitalize "a" === "A"

let _ = assert : Text/capitalize "bar" === "Bar"

let _ = assert : Text/capitalize "Cat" === "Cat"

let _ = assert : Text/capitalize "" === ""

in  Text/capitalize
