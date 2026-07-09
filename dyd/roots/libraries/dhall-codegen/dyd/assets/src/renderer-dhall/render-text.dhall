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

let renderTextType
    : s.text.variants → RenderContext → Text
    = λ(variant : s.text.variants) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let expression =
              merge
                { none = "${p0}Text"
                , email = "${p0}Text"
                , url = "${p0}Text"
                , literal = λ(x : Text) → "${p0}Text"
                }
                variant

        in  expression

let renderText
    : s.text.node.Type → RenderFragment
    = λ(node : s.text.node.Type) →
      λ(ctx : RenderContext) →
        let p0 = renderPrefix ctx

        let header = ""

        let type = Some (renderTextType node.props.variant ctx)

        let description = renderDescription node.meta.description ctx

        let body = [ description, type ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = ""

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderText
