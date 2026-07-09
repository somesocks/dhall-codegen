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

let renderReference
    : Schema.reference.node.Type → RenderFragment
    = λ(node : Schema.reference.node.Type) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let defsKeyword =
              merge
                { DRAFT_2020_12 = "\$defs", DRAFT_07 = "definitions" }
                ctx.variant

        let header = "${p0}{"

        let body = "${p1}\"\$ref\": \"#/${defsKeyword}/${node.props.to}\""

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderReference
