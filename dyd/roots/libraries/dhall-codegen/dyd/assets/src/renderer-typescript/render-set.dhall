let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let SetNode = (Schema.set.nodeF RenderFragment).Type

let renderSet
    : SetNode -> RenderFragment
    = \(node : SetNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx

        let e1 = (node.props.values ctx2).expression

        let definition =
              merge
                { none = "${p1}Set<${e1}${p1}>"
                , list = "${p1}Array<${e1}${p1}>"
                }
                node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderSet
