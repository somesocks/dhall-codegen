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

let AllOfNode = (s.allOf.nodeF RenderFragment).Type

let renderAllOf
    : AllOfNode -> RenderFragment
    = \(x : AllOfNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = "Annotated[Any, _check_all_of("

        let renderBodyLine =
              \(x : RenderFragment) -> "TypeAdapter(${(x ctx2).expression})"

        let body = List/map RenderFragment Text renderBodyLine x.props.options

        let body = Text/concatSep ", " body

        let footer = ")]"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderAllOf
