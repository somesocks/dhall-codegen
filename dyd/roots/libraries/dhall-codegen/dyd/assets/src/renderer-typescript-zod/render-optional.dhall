let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let OptionalNode = (s.optional.nodeF RenderFragment).Type

let renderOptional
    : OptionalNode -> RenderFragment
    = \(node : OptionalNode) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let ctx2 = ctx // { depth = ctx.depth }

        let definition = (node.props.value ctx2).expression ++ ".optional()"

        let expression = definition ++ description

        in  { expression }

in  renderOptional
