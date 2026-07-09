let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderAny
    : s.any.node.Type -> RenderFragment
    = \(node : s.any.node.Type) ->
      \(ctx : RenderContext) ->
        let any =
              merge
                { none = "z.unknown()", permissive = "z.any()" }
                node.props.variant

        let description = renderZodDescription node.meta.description

        let definition = renderPrefix ctx ++ any

        let expression = definition ++ description

        in  { expression }

in  renderAny
