let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderZod3TimeVariant
    : s.time.variants -> Text
    = \(variant : s.time.variants) ->
        merge
          { none = "z.date()" }
          variant

let renderZod4TimeVariant
    : s.time.variants -> Text
    = \(variant : s.time.variants) ->
        merge { none = "z.date()" } variant

let renderTime
    : s.time.node.Type -> RenderFragment
    = \(node : s.time.node.Type) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let definition =
              merge
                { ZOD_3 =
                    renderPrefix ctx ++ renderZod3TimeVariant node.props.variant
                , ZOD_3_RECURSION =
                    renderPrefix ctx ++ renderZod3TimeVariant node.props.variant
                , ZOD_4 =
                    renderPrefix ctx ++ renderZod4TimeVariant node.props.variant
                , ZOD_4_RECURSION =
                    renderPrefix ctx ++ renderZod4TimeVariant node.props.variant
                }
                ctx.options.variant

        let expression = definition ++ description

        in  { expression }

in  renderTime
