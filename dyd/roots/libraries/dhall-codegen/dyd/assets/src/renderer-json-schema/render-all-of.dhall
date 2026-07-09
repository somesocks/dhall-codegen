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

let renderDescription2 = ./render-description-2.dhall

let AllOfNode = (Schema.allOf.nodeF RenderFragment).Type

let renderAllOf
    : AllOfNode → RenderFragment
    = λ(node : AllOfNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let renderOptionLine = λ(x : RenderFragment) → (x ctx2).expression

        let header = "${p0}{"

        let allOfStart = "${p1}\"allOf\" : ["

        let allOfEnd = "${p1}]"

        let allOf =
              List/map RenderFragment Text renderOptionLine node.props.options

        let allOf = Text/concatSep "," allOf

        let allOf = allOfStart ++ allOf ++ allOfEnd

        let allOf = Some allOf

        let description = renderDescription2 node.meta.description ctx1

        let body = [ allOf, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderAllOf
