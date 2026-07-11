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

let ListNode = (Schema.list.nodeF RenderFragment).Type

let renderList
    : ListNode → RenderFragment
    = λ(node : ListNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let e1 = (node.props.values ctx2).expression

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"array\""

        let items = Some "${p1}\"items\" :${e1}"

        let description = renderDescription2 node.meta.description ctx1

        let body = [ type, items, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderList
