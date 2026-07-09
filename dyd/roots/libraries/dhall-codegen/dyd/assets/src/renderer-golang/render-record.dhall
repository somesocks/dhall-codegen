let List/map = ../prelude/List/map.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/snakeCase = ../utils/Text/snakeCase.dhall

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
        let value = x.mapValue ctx

        let fieldName = Text/snakeCase x.mapKey

        let tag = "`json:\"${x.mapKey}\"`"

        let expression =
              renderPrefix ctx
              ++  fieldName
              ++  " "
              ++  value.expression
              ++  " "
              ++  tag

        in  expression

let renderOptionalRecordField
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let value = x.mapValue ctx

        let fieldName = Text/snakeCase x.mapKey

        let tag = "`json:\"${x.mapKey},omitempty\"`"

        let expression =
              renderPrefix ctx
              ++  fieldName
              ++  " "
              ++  "*"
              ++  value.expression
              ++  " "
              ++  tag

        in  expression

let renderInterfaceRequiredMethod
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let value = x.mapValue ctx

        let methodName = Text/snakeCase x.mapKey

        let expression =
              renderPrefix ctx
              ++  methodName
              ++  "() "
              ++  value.expression

        in  expression

let renderInterfaceOptionalMethod
    : RenderContext -> { mapKey : Text, mapValue : RenderFragment } -> Text
    = \(ctx : RenderContext) ->
      \(x : { mapKey : Text, mapValue : RenderFragment }) ->
        let value = x.mapValue ctx

        let methodName = Text/snakeCase x.mapKey

        let expression =
              renderPrefix ctx
              ++  methodName
              ++  "() "
              ++  "*"
              ++  value.expression

        in  expression

let renderRecord
    : RecordNode -> RenderFragment
    = \(x : RecordNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header =
              merge
                { none = "struct {", interface = "interface {" }
                x.props.variant

        let body =
              merge
                { none =
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
                , interface =
                    List/map
                      { mapKey : Text, mapValue : RenderFragment }
                      Text
                      (renderInterfaceRequiredMethod ctx2)
                      x.props.required
                  # List/map
                      { mapKey : Text, mapValue : RenderFragment }
                      Text
                      (renderInterfaceOptionalMethod ctx2)
                      x.props.optional
                }
                x.props.variant

        let body = Text/concat body

        let footer = renderPrefix ctx ++ "}"

        let definition = header ++ body ++ footer

        let expression = description ++ definition

        in  { expression, name = x.meta.name }

in  renderRecord
