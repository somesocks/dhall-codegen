let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderZodDescription
    : Optional Text -> Text
    = \(description : Optional Text) ->
        let expression =
              merge
                { None = ""
                , Some =
                    \(description : Text) ->
                      let expression = Text/replace "\n" " " description

                      let expression = Text/replace "\"" "\\\"" expression

                      let expression = ".describe(\"${expression}\")"

                      in  expression
                }
                description

        in  expression

in  renderZodDescription
