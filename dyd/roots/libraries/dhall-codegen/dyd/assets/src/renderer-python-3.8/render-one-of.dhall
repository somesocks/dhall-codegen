let List/map = ../prelude/List/map.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let OneOfNode = (s.oneOf.nodeF RenderFragment).Type

let renderOneOf
    : OneOfNode -> RenderFragment
    = \(node : OneOfNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = "Union["

        let renderBodyLine = \(x : RenderFragment) -> (x ctx2).expression

        let body =
              List/map RenderFragment Text renderBodyLine node.props.options

        let body = Text/concatSep "," body

        let footer = "]"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderOneOf
