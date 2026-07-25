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

let renderTimeFormat
    : s.time.variants → RenderContext → Optional Text
    = λ(variant : s.time.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        in  merge
              { none = Some "${p0}\"format\" : \"date-time\""
              , date = Some "${p0}\"format\" : \"date\""
              , time = None Text
              }
              variant

let renderTimePattern
    : s.time.variants → RenderContext → Optional Text
    = λ(variant : s.time.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        in  merge
              { none = None Text
              , date = None Text
              , time = Some "${p0}\"pattern\" : \"^(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](?:[.][0-9]+)?(?![\\\\s\\\\S])\""
              }
              variant

let renderTime
    : Schema.time.node.Type → RenderFragment
    = λ(node : Schema.time.node.Type) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"string\""

        let description = renderDescription2 node.meta.description ctx1

        let format = renderTimeFormat node.props.variant ctx1

        let pattern = renderTimePattern node.props.variant ctx1

        let body = [ type, description, format, pattern ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderTime
