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

let renderReference
    : Schema.reference.node.Type → RenderFragment
    = λ(node : Schema.reference.node.Type) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let header = ""

        let body = "${p0}${node.props.to}"

        let footer = ""

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderReference
