let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

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

                      let expression =
                            Text/replace
                              "\n"
                              (prefix ++ "# ")
                              ("# " ++ description)

                      in  expression
                }
                description

        in  { expression, type = ExpressionType.None }

in  renderDescription
