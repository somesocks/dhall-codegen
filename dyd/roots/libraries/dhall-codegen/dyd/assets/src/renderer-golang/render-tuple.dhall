let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let TupleNode = (Schema.tuple.nodeF RenderFragment).Type

let renderTupleField
    : RenderContext -> Natural -> RenderFragment -> Text
    = \(ctx : RenderContext) ->
      \(index : Natural) ->
      \(value : RenderFragment) ->
        let rendered = value ctx

        let name = "Item${Natural/show (index + 1)}"

        let tag = "item${Natural/show (index + 1)}"

        let tag = "`json:\"${tag}\"`"

        let expression =
              renderPrefix ctx
              ++  name
              ++  " "
              ++  rendered.expression
              ++  " "
              ++  tag

        in  expression

let renderTuple
    : TupleNode -> RenderFragment
    = \(x : TupleNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = "struct {"

        let body =
              List/mapWithIndex
                RenderFragment
                Text
                (renderTupleField ctx2)
                x.props.values

        let body = Text/concat body

        let footer = renderPrefix ctx ++ "}"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression, name = x.meta.name }

in  renderTuple
