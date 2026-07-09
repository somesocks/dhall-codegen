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

let MapNode = (Schema.map.nodeF RenderFragment).Type

let renderMap
    : MapNode → RenderFragment
    = λ(node : MapNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let ctx3 = ctx ⫽ { depth = ctx.depth + 3 }

        let ctx4 = ctx ⫽ { depth = ctx.depth + 4 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let p2 = renderPrefix ctx2

        let p3 = renderPrefix ctx3

        let k1 = (node.props.keys ctx4).expression

        let v1 = (node.props.values ctx4).expression

        let header = "${p0}("

        let type = Some "${p1}List"

        let items = Some "${p2}{${p3}mapKey :${k1}${p3}, mapValue :${v1}${p2}}"

        let description = renderDescription node.meta.description ctx

        let body = [ description, type, items ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = "${p0})"

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderMap
