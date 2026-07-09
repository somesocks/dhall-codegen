let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let ListNode = (Schema.list.nodeF RenderFragment).Type

let renderList
    : ListNode -> RenderFragment
    = \(node : ListNode) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let definition =
                  renderPrefix ctx
              ++  "z.array("
              ++  (node.props.values ctx2).expression
              ++  renderPrefix ctx
              ++  ")"

        let expression = definition ++ description

        in  { expression }

in  renderList
