let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let SetNode = (s.set.nodeF RenderFragment).Type

let renderSet
    : SetNode -> RenderFragment
    = \(node : SetNode) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let definition =
              merge
                { none =
                        renderPrefix ctx
                    ++  "z.set("
                    ++  (node.props.values ctx2).expression
                    ++  renderPrefix ctx
                    ++  ")"
                , list =
                        renderPrefix ctx
                    ++  "z.array("
                    ++  (node.props.values ctx2).expression
                    ++  renderPrefix ctx
                    ++  ")"
                }
                node.props.variant

        let expression = definition ++ description

        in  { expression }

in  renderSet
