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

let renderNumberVariant
    : s.number.variants → Text
    = λ(variant : s.number.variants) →
        merge
          { none = "Double"
          , natural = "Natural"
          , integer = "Integer"
          , decimal = "Double"
          }
          variant

let renderNumber
    : s.number.node.Type → RenderFragment
    = λ(node : s.number.node.Type) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let header = ""

        let variant = renderNumberVariant node.props.variant

        let type = Some "${p0}${variant}"

        let description = renderDescription node.meta.description ctx

        let body = [ description, type ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = ""

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderNumber
