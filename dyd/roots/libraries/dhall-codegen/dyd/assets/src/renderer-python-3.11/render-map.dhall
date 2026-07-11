let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let MapNode = (s.map.nodeF RenderFragment).Type

let renderMap
    : MapNode -> RenderFragment
    = \(node : MapNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx

        let e1 = (node.props.keys ctx2).expression

        let e2 = (node.props.values ctx2).expression

        let definition = "dict[${e1}, ${e2}]"

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderMap
