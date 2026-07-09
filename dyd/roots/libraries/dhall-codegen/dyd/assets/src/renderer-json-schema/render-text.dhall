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

        let body = [ type, description, format ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderText
