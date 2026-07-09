let List/map = ../prelude/List/map.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let AllOfNode = (Schema.allOf.nodeF RenderFragment).Type

let renderAllOfField
    : RenderContext -> RenderFragment -> Text
    = \(ctx : RenderContext) ->
      \(opt : RenderFragment) ->
        let value = opt ctx

        let expression = renderPrefix ctx ++ value.expression

        in  expression

let renderAllOf
    : AllOfNode -> RenderFragment
    = \(x : AllOfNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = "struct {"

        let body =
              List/map
                RenderFragment
                Text
                (renderAllOfField ctx2)
                x.props.options

        let body = Text/concat body

        let footer = renderPrefix ctx ++ "}"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression, name = x.meta.name }

in  renderAllOf
