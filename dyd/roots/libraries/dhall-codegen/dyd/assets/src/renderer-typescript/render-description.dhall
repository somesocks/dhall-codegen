let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription
    : Optional Text -> RenderFragment
    = \(description : Optional Text) ->
      \(ctx : RenderContext) ->
        let expression =
              merge
                { None = ""
                , Some =
                    \(description : Text) ->
                      let prefix = renderPrefix ctx

                      let expression = Text/replace "\n" prefix description

                      let expression = "${prefix}/** ${expression} */"

                      in  expression
                }
                description

        in  { expression }

in  renderDescription
