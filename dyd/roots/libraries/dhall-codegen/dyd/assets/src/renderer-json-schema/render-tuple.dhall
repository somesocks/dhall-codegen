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

let TupleNode = (Schema.tuple.nodeF RenderFragment).Type

let renderTupleDraft202012
    : TupleNode → RenderFragment
    = λ(node : TupleNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let renderValueLine = λ(x : RenderFragment) → (x ctx2).expression

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"array\""

        let prefixItemsStart = "${p1}\"prefixItems\" : ["

        let prefixItemsEnd = "${p1}]"

        let prefixItems =
              List/map RenderFragment Text renderValueLine node.props.values

        let prefixItems = Text/concatSep "," prefixItems

        let prefixItems =
              Some (prefixItemsStart ++ prefixItems ++ prefixItemsEnd)

        let items = Some "${p1}\"items\" : false"

        let description = renderDescription2 node.meta.description ctx1

        let body = [ type, prefixItems, items, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

let renderTupleDraft07
    : TupleNode → RenderFragment
    = λ(node : TupleNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let renderValueLine = λ(x : RenderFragment) → (x ctx2).expression

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"array\""

        let prefixItemsStart = "${p1}\"items\" : ["

        let prefixItemsEnd = "${p1}]"

        let prefixItems =
              List/map RenderFragment Text renderValueLine node.props.values

        let prefixItems = Text/concatSep "," prefixItems

        let prefixItems =
              Some (prefixItemsStart ++ prefixItems ++ prefixItemsEnd)

        let items = Some "${p1}\"additionalItems\" : false"

        let description = renderDescription2 node.meta.description ctx1

        let body = [ type, prefixItems, items, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

let renderTuple
    : TupleNode → RenderFragment
    = λ(node : TupleNode) →
      λ(ctx : RenderContext) →
        merge
          { DRAFT_2020_12 = renderTupleDraft202012 node ctx
          , DRAFT_07 = renderTupleDraft07 node ctx
          }
          ctx.variant

in  renderTuple
