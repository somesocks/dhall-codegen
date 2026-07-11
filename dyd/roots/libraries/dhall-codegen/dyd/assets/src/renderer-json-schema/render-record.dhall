let List/map = ../prelude/List/map.dhall

let List/unpackOptionals = ../prelude/List/unpackOptionals.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription2 = ./render-description-2.dhall

let RecordNode = (Schema.record.nodeF RenderFragment).Type

let renderRecordField
    : { mapKey : Text, mapValue : RenderFragment } → RenderContext → Text
    = λ(node : { mapKey : Text, mapValue : RenderFragment }) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let value = node.mapValue ctx1

        let expression =
                  renderPrefix ctx
              ++  "\"${node.mapKey}\""
              ++  " :"
              ++  value.expression

        in  expression

let renderRecordKey
    : { mapKey : Text, mapValue : RenderFragment } → RenderContext → Text
    = λ(node : { mapKey : Text, mapValue : RenderFragment }) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let expression = renderPrefix ctx ++ "\"${node.mapKey}\""

        in  expression

let renderRecord
    : RecordNode → RenderFragment
    = λ(node : RecordNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let renderFieldLine =
              λ(x : { mapKey : Text, mapValue : RenderFragment }) →
                renderRecordField x ctx2

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"object\""

        let propertiesStart = "${p1}\"properties\" : {"

        let propertiesEnd = "${p1}}"

        let properties =
                List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  renderFieldLine
                  node.props.required
              # List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  renderFieldLine
                  node.props.optional

        let properties = Text/concatSep "," properties

        let properties = Some (propertiesStart ++ properties ++ propertiesEnd)

        let renderRequiredLine =
              λ(x : { mapKey : Text, mapValue : RenderFragment }) →
                renderRecordKey x ctx2

        let requiredStart = "${p1}\"required\" : ["

        let requiredEnd = "${p1}]"

        let required =
              List/map
                { mapKey : Text, mapValue : RenderFragment }
                Text
                renderRequiredLine
                node.props.required

        let required = Text/concatSep "," required

        let required = Some (requiredStart ++ required ++ requiredEnd)

        let additionalProperties = Some "${p1}\"additionalProperties\" : false"

        let description = renderDescription2 node.meta.description ctx1

        let body =
              [ type, properties, required, additionalProperties, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderRecord
