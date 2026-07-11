let List/map = ../prelude/List/map.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderRequiredRecordField
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let value = x.mapValue ctx

        let expression =
              renderPrefix ctx ++ x.mapKey ++ " : " ++ value.expression

        in  expression

let renderOptionalRecordField
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let value = x.mapValue ctx

        let expression =
                  renderPrefix ctx
              ++  x.mapKey
              ++  " : "
              ++  "(${value.expression}) | None"

        in  expression

let RecordNode = (s.record.nodeF RenderFragment).Type

let renderRecord
    : RecordNode -> RenderFragment
    = \(x : RecordNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = ""

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

        let footer = ""

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        let type =
              merge
                { none = ExpressionType.Class
                , interface = ExpressionType.Protocol
                }
                x.props.variant

        in  { expression, type }

in  renderRecord
