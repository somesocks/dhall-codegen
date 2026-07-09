let List/map = ../prelude/List/map.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let AllOfNode = (Schema.allOf.nodeF RenderFragment).Type

let renderAllOf
    : AllOfNode -> RenderFragment
    = \(x : AllOfNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = renderPrefix ctx ++ "("

        let renderBodyLine = \(x : RenderFragment) -> (x ctx2).expression

        let body = List/map RenderFragment Text renderBodyLine x.props.options

        let body = Text/concatSep " &" body

        let footer = renderPrefix ctx ++ ")"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression }

in  renderAllOf
