let Text/replicate = ../prelude/Text/replicate.dhall

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription
    : Optional Text → RenderFragment
    = λ(description : Optional Text) →
      λ(ctx : RenderContext) →
        let expression =
              merge
                { None = ""
                , Some =
                    λ(description : Text) →
                      let prefix = renderPrefix ctx

                      let expression = Text/replace "\n" " " description

                      let expression = Text/replace "\"" "\\\"" description

                      let expression = "\"description\" : \"${expression}\""

                      in  expression
                }
                description

        in  { expression }

in  renderDescription
