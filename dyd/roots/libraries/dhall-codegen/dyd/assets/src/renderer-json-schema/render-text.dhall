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

let renderTextType
    : s.text.variants → RenderContext → Text
    = λ(variant : s.text.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let expression =
              merge
                { none = "${p0}\"type\": \"string\""
                , email = "${p0}\"type\": \"string\""
                , url = "${p0}\"type\": \"string\""
                , base64 = "${p0}\"type\": \"string\""
                , base64url = "${p0}\"type\": \"string\""
                , e164 = "${p0}\"type\": \"string\""
                , ipv4 = "${p0}\"type\": \"string\""
                , ipv6 = "${p0}\"type\": \"string\""
                , isoDate = "${p0}\"type\": \"string\""
                , isoDateTime = "${p0}\"type\": \"string\""
                , isoDuration = "${p0}\"type\": \"string\""
                , isoTime = "${p0}\"type\": \"string\""
                , uuid = "${p0}\"type\": \"string\""
                , literal = λ(x : Text) → "${p0}\"const\": \"${x}\""
                }
                variant

        in  expression

let renderTextFormat
    : s.text.variants → RenderContext → Optional Text
    = λ(variant : s.text.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let expression =
              merge
                { none = None Text
                , email = Some "${p0}\"format\": \"email\""
                , url = Some "${p0}\"format\": \"uri\""
                , base64 = None Text
                , base64url = None Text
                , e164 = None Text
                , ipv4 = Some "${p0}\"format\": \"ipv4\""
                , ipv6 = Some "${p0}\"format\": \"ipv6\""
                , isoDate = Some "${p0}\"format\": \"date\""
                , isoDateTime = Some "${p0}\"format\": \"date-time\""
                , isoDuration = Some "${p0}\"format\": \"duration\""
                , isoTime = Some "${p0}\"format\": \"time\""
                , uuid = Some "${p0}\"format\": \"uuid\""
                , literal = λ(x : Text) → None Text
                }
                variant

        in  expression

let renderTextContentEncoding
    : s.text.variants → RenderContext → Optional Text
    = λ(variant : s.text.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let expression =
              merge
                { none = None Text
                , email = None Text
                , url = None Text
                , base64 = Some "${p0}\"contentEncoding\": \"base64\""
                , base64url = Some "${p0}\"contentEncoding\": \"base64url\""
                , e164 = None Text
                , ipv4 = None Text
                , ipv6 = None Text
                , isoDate = None Text
                , isoDateTime = None Text
                , isoDuration = None Text
                , isoTime = None Text
                , uuid = None Text
                , literal = λ(x : Text) → None Text
                }
                variant

        in  expression

let renderTextPattern
    : s.text.variants → RenderContext → Optional Text
    = λ(variant : s.text.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let expression =
              merge
                { none = None Text
                , email = None Text
                , url = None Text
                , base64 = Some "${p0}\"pattern\": \"^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}(?:==)?|[A-Za-z0-9+/]{3}=?)?$\""
                , base64url = Some "${p0}\"pattern\": \"^(?:[A-Za-z0-9_-]{4})*(?:[A-Za-z0-9_-]{2}(?:==)?|[A-Za-z0-9_-]{3}=?)?$\""
                , e164 = Some "${p0}\"pattern\": \"^[+][1-9][0-9]{0,14}$\""
                , ipv4 = None Text
                , ipv6 = None Text
                , isoDate = None Text
                , isoDateTime = None Text
                , isoDuration = None Text
                , isoTime = None Text
                , uuid = None Text
                , literal = λ(x : Text) → None Text
                }
                variant

        in  expression

let renderText
    : s.text.node.Type → RenderFragment
    = λ(node : s.text.node.Type) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let header = "${p0}{"

        let type = Some (renderTextType node.props.variant ctx1)

        let description = renderDescription2 node.meta.description ctx1

        let format = renderTextFormat node.props.variant ctx1

        let contentEncoding = renderTextContentEncoding node.props.variant ctx1

        let pattern = renderTextPattern node.props.variant ctx1

        let body = [ type, description, format, contentEncoding, pattern ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderText
