let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let MapNode = (s.map.nodeF RenderFragment).Type

let renderMap
    : MapNode -> RenderFragment
    = \(node : MapNode) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let definition =
              merge
                { none =
                        renderPrefix ctx
                    ++  "z.map("
                    ++  (node.props.keys ctx2).expression
                    ++  ","
                    ++  (node.props.values ctx2).expression
                    ++  renderPrefix ctx
                    ++  ")"
                , record =
                        renderPrefix ctx
                    ++  "z.record("
                    ++  (node.props.keys ctx2).expression
                    ++  ","
                    ++  (node.props.values ctx2).expression
                    ++  renderPrefix ctx
                    ++  ")"
                }
                node.props.variant

        let expression = definition ++ description

        in  { expression }

in  renderMap
