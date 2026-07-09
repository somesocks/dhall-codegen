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

let renderTime
    : Schema.time.node.Type → RenderFragment
    = λ(node : Schema.time.node.Type) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

        let header = "${p0}{"

        let type = Some "${p1}\"type\" : \"string\""

        let description = renderDescription2 node.meta.description ctx1

        let format = Some "${p1}\"format\" : \"date-time\""

        let body = [ type, description, format ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "," body

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  { expression }

in  renderTime
