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

let renderDescription = ./render-description.dhall

let RecordNode = (Schema.record.nodeF RenderFragment).Type

let renderRequiredField
    : RenderContext → { mapKey : Text, mapValue : RenderFragment } → Text
    = λ(ctx : RenderContext) →
      λ(x : { mapKey : Text, mapValue : RenderFragment }) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let entry = "${p0}${x.mapKey} :${(x.mapValue ctx1).expression}"

        in  entry

let renderOptionalField
    : RenderContext → { mapKey : Text, mapValue : RenderFragment } → Text
    = λ(ctx : RenderContext) →
      λ(x : { mapKey : Text, mapValue : RenderFragment }) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let entry =
              "${p0}${x.mapKey} : Optional ${(x.mapValue ctx1).expression}"

        in  entry

let renderRecord
    : RecordNode → RenderFragment
    = λ(node : RecordNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let renderRequiredLine = renderRequiredField ctx1

        let renderOptionalLine = renderOptionalField ctx1

        let header = "${p0}{"

        let fields =
                List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  renderRequiredLine
                  node.props.required
              # List/map
                  { mapKey : Text, mapValue : RenderFragment }
                  Text
                  renderOptionalLine
                  node.props.optional

        let fields = Text/concatSep "," fields

        let fields = Some fields

        let description = renderDescription node.meta.description ctx1

        let body = [ description, fields ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderRecord
