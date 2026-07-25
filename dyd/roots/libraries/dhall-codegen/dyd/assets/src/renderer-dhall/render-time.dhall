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

let renderTimeVariant
    : s.time.variants → Text
    = λ(variant : s.time.variants) → merge { none = "Time", date = "Date", time = "Time", duration = "Text" } variant

let renderTime
    : Schema.time.node.Type → RenderFragment
    = λ(node : Schema.time.node.Type) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let header = ""

        let type = Some "${p0}${renderTimeVariant node.props.variant}"

        let description = renderDescription node.meta.description ctx

        let body = [ description, type ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = ""

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderTime
