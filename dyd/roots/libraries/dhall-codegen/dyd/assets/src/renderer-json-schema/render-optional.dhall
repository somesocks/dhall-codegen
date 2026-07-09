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

let OptionalNode = (Schema.optional.nodeF RenderFragment).Type

let renderOptional
    : OptionalNode → RenderFragment
    = λ(node : OptionalNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let p2 = renderPrefix ctx2

        let header = "${p0}{"

        let oneOfStart = "${p1}\"oneOf\" : ["

        let oneOfEnd = "${p1}]"

        let oneOf =
              [ (node.props.value ctx2).expression
              , "${p2}{ \"type\": \"null\" }"
              ]

        let oneOf = Text/concatSep "," oneOf

        let oneOf = oneOfStart ++ oneOf ++ oneOfEnd

        let oneOf = Some oneOf

        let description = renderDescription2 node.meta.description ctx1

        let body = [ oneOf, description ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderOptional
