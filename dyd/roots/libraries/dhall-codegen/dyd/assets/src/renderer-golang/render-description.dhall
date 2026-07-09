let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription
    : Optional Text -> RenderFragment
    = \(description : Optional Text) ->
      \(ctx : RenderContext) ->
        let expression =
              if    ctx.options.emitDescriptions && Natural/isZero ctx.depth
              then  merge
                      { None = ""
                      , Some =
                          \(description : Text) ->
                            let body = Text/replace "\n" " " description

                            let expression = "// ${body}"

                            in  expression
                      }
                      description
              else  ""

        in  { expression, name = None Text }

in  renderDescription
