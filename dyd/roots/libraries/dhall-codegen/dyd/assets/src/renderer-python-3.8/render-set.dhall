let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let SetNode = (s.set.nodeF RenderFragment).Type

let renderSet
    : SetNode -> RenderFragment
    = \(node : SetNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let e1 = (node.props.values ctx2).expression

        let definition =
              merge
                { none = "Set[${e1}]", list = "List[${e1}]" }
                node.props.variant

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderSet
