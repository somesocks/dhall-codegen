let List/unpackOptionals = ../prelude/List/unpackOptionals.dhall

let List/zeroOneMany = ../prelude/List/zeroOneMany.dhall

let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let FunctionNode = (Schema.function.nodeF RenderFragment).Type

let renderFunctionInputZero
    : RenderContext → {} → Text
    = λ(ctx : RenderContext) →
      λ(_ : {}) →
        let p0 = renderPrefix ctx let expression = "${p0}{} ->" in expression

let renderFunctionInputOne
    : RenderContext → RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : RenderFragment) →
        let expression = "${(x ctx).expression} ->" in expression

let renderFunctionInputMany
    : RenderContext → List RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : List RenderFragment) →
        let expression =
              List/map RenderFragment Text (renderFunctionInputOne ctx) x

        let expression = Text/concat expression

        in  expression

let renderFunctionInput
    : RenderContext → List RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : List RenderFragment) →
        List/zeroOneMany
          RenderFragment
          Text
          (renderFunctionInputZero ctx)
          (renderFunctionInputOne ctx)
          (renderFunctionInputMany ctx)
          x

let renderFunctionOutputZero
    : RenderContext → {} → Text
    = λ(ctx : RenderContext) →
      λ(_ : {}) →
        let p0 = renderPrefix ctx let expression = "${p0}{}" in expression

let renderFunctionOutputOne
    : RenderContext → RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : RenderFragment) →
        let p0 = renderPrefix ctx

        let expression = "${(x ctx).expression}"

        in  expression

let renderFunctionOutputManyEntry
    : RenderContext → Natural → RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(index : Natural) →
      λ(x : RenderFragment) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let name = "_${Natural/show (index + 1)}"

        let entry = "${p0}${name} :${(x ctx1).expression}"

        in  entry

let renderFunctionOutputMany
    : RenderContext → List RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : List RenderFragment) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p0 = renderPrefix ctx

        let renderLine = renderFunctionOutputManyEntry ctx1

        let header = "${p0}{"

        let fields = List/mapWithIndex RenderFragment Text renderLine x

        let fields = Text/concatSep "," fields

        let body = fields

        let footer = "${p0}}"

        let expression = header ++ body ++ footer

        in  expression

let renderFunctionOutput
    : RenderContext → List RenderFragment → Text
    = λ(ctx : RenderContext) →
      λ(x : List RenderFragment) →
        List/zeroOneMany
          RenderFragment
          Text
          (renderFunctionOutputZero ctx)
          (renderFunctionOutputOne ctx)
          (renderFunctionOutputMany ctx)
          x

let renderFunction
    : FunctionNode → RenderFragment
    = λ(node : FunctionNode) →
      λ(ctx : RenderContext) →
        let input = renderFunctionInput ctx node.props.input

        let output = renderFunctionOutput ctx node.props.output

        let expression = input ++ output

        in  { expression, name = node.meta.name }

in  renderFunction
