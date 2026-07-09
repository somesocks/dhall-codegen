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

let RecordNode = (Schema.record.nodeF RenderFragment).Type

let renderRequiredRecordField
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let value = x.mapValue ctx2

        let expression =
              renderPrefix ctx ++ x.mapKey ++ " :" ++ value.expression ++ ";"

        in  expression

let renderOptionalRecordField
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let value = x.mapValue ctx2

        let expression =
              renderPrefix ctx ++ x.mapKey ++ " ?:" ++ value.expression ++ ";"

        in  expression

let renderRecord
    : RecordNode -> RenderFragment
    = \(x : RecordNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = renderPrefix ctx ++ "{"

        let body =
                List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  (renderRequiredRecordField ctx2)
                  x.props.required
              # List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  (renderOptionalRecordField ctx2)
                  x.props.optional

        let body = Text/concat body

        let footer = renderPrefix ctx ++ "}"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression }

in  renderRecord
