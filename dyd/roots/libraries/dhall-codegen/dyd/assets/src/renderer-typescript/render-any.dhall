let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderAny
    : s.any.node.Type -> RenderFragment
    = \(node : s.any.node.Type) ->
      \(ctx : RenderContext) ->
        let any =
              merge { none = "unknown", permissive = "any" } node.props.variant

        let description =
              (renderDescription node.meta.description ctx).expression

        let definition = renderPrefix ctx ++ any

        let expression = description ++ definition

        in  { expression }

in  renderAny
