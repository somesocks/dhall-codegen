let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let ListNode = (Schema.list.nodeF RenderFragment).Type

let renderList
    : ListNode -> RenderFragment
    = \(node : ListNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx

        let e1 = (node.props.values ctx2).expression

        let definition = "${p1}Array<${e1}${p1}>"

        let expression = description ++ definition

        in  { expression }

in  renderList
