let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let MapNode = (Schema.map.nodeF RenderFragment).Type

let renderMap
    : MapNode -> RenderFragment
    = \(node : MapNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx

        let e1 = (node.props.keys ctx2).expression

        let e2 = (node.props.values ctx2).expression

        let definition =
              merge
                { none = "${p1}Map<${e1},${e2}${p1}>"
                , record = "${p1}Record<${e1},${e2}${p1}>"
                }
                node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderMap
