let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderReference
    : s.reference.node.Type -> RenderFragment
    = \(node : s.reference.node.Type) ->
      \(ctx : RenderContext) ->
        let description = ""

        let definition = node.props.to

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderReference
