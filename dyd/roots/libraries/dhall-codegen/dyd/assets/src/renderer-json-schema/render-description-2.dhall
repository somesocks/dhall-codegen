let Text/replicate = ../prelude/Text/replicate.dhall

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription2
    : Optional Text → RenderContext → Optional Text
    = λ(description : Optional Text) →
      λ(ctx : RenderContext) →
        merge
          { None = None Text
          , Some =
              λ(description : Text) →
                let p0 = renderPrefix ctx

                let expression = description

                let expression = Text/replace "\n" "\\n" expression

                let expression = Text/replace "\"" "\\\"" expression

                let expression = "${p0}\"description\" : \"${expression}\""

                in  Some expression
          }
          description

in  renderDescription2
