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

let OneOfNode = (Schema.oneOf.nodeF RenderFragment).Type

let renderOneOf
    : OneOfNode → RenderFragment
    = λ(node : OneOfNode) →
      λ(ctx : RenderContext) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let ctx2 = ctx ⫽ { depth = ctx.depth + 2 }

        let p0 = renderPrefix ctx

        let p1 = renderPrefix ctx1

let renderOptionLine =
      λ(index : Natural) →
      λ(x : RenderFragment) →
        let rendered = x ctx2

        let optionName =
              merge
                { None = "Option${Natural/show index}"
                , Some = \(name : Text) -> name
                }
                rendered.name

        in  "${p1}${optionName} :${rendered.expression}"

        let oneOfStart = "${p0}<"

        let oneOfEnd = "${p0}>"

        let oneOf =
              List/mapWithIndex
                RenderFragment
                Text
                renderOptionLine
                node.props.options

        let oneOf = Text/concatSep " |" oneOf

        let oneOf = oneOfStart ++ oneOf ++ oneOfEnd

        let oneOf = Some oneOf

        let description = renderDescription node.meta.description ctx1

        let body = [ description, oneOf ]

        let body = List/unpackOptionals Text body

        let body = Text/concatSep "" body

        let expression = body

        in  { expression, name = node.meta.name }

in  renderOneOf
