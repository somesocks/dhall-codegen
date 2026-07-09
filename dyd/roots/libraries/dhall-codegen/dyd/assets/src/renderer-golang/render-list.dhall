let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let ListNode = (Schema.list.nodeF RenderFragment).Type

let renderList
    : ListNode -> RenderFragment
    = \(node : ListNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let values = (node.props.values ctx).expression

        let definition = "[]" ++ values

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderList
