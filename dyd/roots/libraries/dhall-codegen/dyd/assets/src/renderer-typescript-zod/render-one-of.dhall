let List/map = ../prelude/List/map.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let OneOfNode = (s.oneOf.nodeF RenderFragment).Type

let renderOneOf
    : OneOfNode -> RenderFragment
    = \(node : OneOfNode) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = renderPrefix ctx ++ "z.union(["

        let renderBodyLine = \(x : RenderFragment) -> (x ctx2).expression

        let body =
              List/map RenderFragment Text renderBodyLine node.props.options

        let body = Text/concatSep "," body

        let footer = renderPrefix ctx ++ "])"

        let definition = header ++ body ++ footer

        let expression = definition ++ description

        in  { expression }

in  renderOneOf
