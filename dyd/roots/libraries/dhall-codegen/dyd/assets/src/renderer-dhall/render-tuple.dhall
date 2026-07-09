let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

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

let TupleNode = (Schema.tuple.nodeF RenderFragment).Type

let renderTupleField
    : RenderContext → Natural → RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(index : Natural) →
      λ(x : RenderFragment) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let name = "_${Natural/show (index + 1)}"

        let entry = "${p0}${name} :${(x ctx1).expression}"

        in  entry

let renderTuple
    : TupleNode → RenderFragment
    = λ(node : TupleNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let renderTupleLine = renderTupleField ctx1

        let header = "${p0}{"

        let fields =
              List/mapWithIndex
                RenderFragment
                Text
                renderTupleLine
                node.props.values

        let fields = Text/concatSep "," fields

        let fields = Some fields

        let description = renderDescription node.meta.description ctx1

        let body = [ description, fields ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderTuple
