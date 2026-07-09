let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let OptionalNode = (s.optional.nodeF RenderFragment).Type

let renderOptional
    : OptionalNode -> RenderFragment
    = \(node : OptionalNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let e1 = (node.props.value ctx2).expression

        let definition = "Optional[${e1}]"

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderOptional
