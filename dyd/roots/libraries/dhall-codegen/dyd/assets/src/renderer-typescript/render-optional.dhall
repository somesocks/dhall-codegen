let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let OptionalNode = (Schema.optional.nodeF RenderFragment).Type

let renderOptional
    : OptionalNode -> RenderFragment
    = \(node : OptionalNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx

        let p2 = renderPrefix ctx2

        let e1 = (node.props.value ctx2).expression

        let definition =
              merge
                { optional = "${p1}(${e1}${p2}| undefined${p1})"
                , nullable = "${p1}(${e1}${p2}| null${p1})"
                , nullish = "${p1}(${e1}${p2}| null${p2}| undefined${p1})"
                }
                node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderOptional
