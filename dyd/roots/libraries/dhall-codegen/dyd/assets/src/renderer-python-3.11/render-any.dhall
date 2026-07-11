let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderAny
    : s.any.node.Type -> RenderFragment
    = \(node : s.any.node.Type) ->
      \(ctx : RenderContext) ->
        let description = ""

        let definition = "Any"

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderAny
