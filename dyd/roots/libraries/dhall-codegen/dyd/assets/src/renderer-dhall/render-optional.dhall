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

let OptionalNode = (Schema.optional.nodeF RenderFragment).Type

let renderOptional
    : OptionalNode → RenderFragment
    = λ(node : OptionalNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let e1 = (node.props.value ctx2).expression

        let header = "${p0}("

        let footer = "${p0})"

        let type = Some "${p1}Optional"

        let items = Some "${e1}"

        let description = renderDescription node.meta.description ctx1

        let body = [ description, type, items ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let expression = header ++ body ++ footer

        in  { expression, name = node.meta.name }

in  renderOptional
