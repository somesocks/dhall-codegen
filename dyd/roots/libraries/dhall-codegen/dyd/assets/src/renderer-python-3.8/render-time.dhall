let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderTimeVariant
    : s.time.variants -> Text
    = \(variant : s.time.variants) -> merge { none = "datetime" } variant

let renderTime
    : s.time.node.Type -> RenderFragment
    = \(node : s.time.node.Type) ->
      \(ctx : RenderContext) ->
        let description = ""

        let definition = renderTimeVariant node.props.variant

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderTime
