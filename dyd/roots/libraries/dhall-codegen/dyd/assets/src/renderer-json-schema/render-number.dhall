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

let renderNumberVariant
    : s.number.variants → Text
    = λ(variant : s.number.variants) →
        merge
          { none = "number"
          , natural = "integer"
          , integer = "integer"
          , decimal = "number"
          }
          variant

let renderNumber
    : s.number.node.Type → RenderFragment
    = λ(node : s.number.node.Type) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let header = "${p0}{"

        let variant = renderNumberVariant node.props.variant

        let type = Some "${p1}\"type\": \"${variant}\""

        let description = renderDescription2 node.meta.description ctx1

        let body = [ type, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderNumber
