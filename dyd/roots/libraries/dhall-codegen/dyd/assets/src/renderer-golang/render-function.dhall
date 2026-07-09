let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let List/zeroOneMany = ../prelude/List/zeroOneMany.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let FunctionNode = (Schema.function.nodeF RenderFragment).Type

let renderFunctionOutputZero
    : RenderContext -> {} -> Text
    = \(ctx : RenderContext) ->
      \(_ : {}) ->
        ""

let renderFunctionOutputOne
    : RenderContext -> RenderFragment -> Text
    = \(ctx : RenderContext) ->
      \(output : RenderFragment) ->
        let value = (output ctx).expression

        in  " " ++ value

let renderFunctionOutputMany
    : RenderContext -> List RenderFragment -> Text
    = \(ctx : RenderContext) ->
      \(outputs : List RenderFragment) ->
        let renderOut = \(x : RenderFragment) -> (x ctx).expression

        let body = Text/concatSep ", " (List/map RenderFragment Text renderOut outputs)

        in  " (" ++ body ++ ")"

let renderFunctionOutput
    : RenderContext -> FunctionNode -> Text
    = \(ctx : RenderContext) ->
      \(node : FunctionNode) ->
        List/zeroOneMany
          RenderFragment
          Text
          (renderFunctionOutputZero ctx)
          (renderFunctionOutputOne ctx)
          (renderFunctionOutputMany ctx)
          node.props.output

let renderFunction
    : FunctionNode -> RenderFragment
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let renderArg =
              \(index : Natural) ->
              \(x : RenderFragment) ->
                let arg = (x ctx).expression

                in  "x${Natural/show index} " ++ arg

        let args =
              Text/concatSep
                ", "
                (List/mapWithIndex RenderFragment Text renderArg node.props.input)

        let output = renderFunctionOutput ctx node

        let definition = "func(" ++ args ++ ")" ++ output

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderFunction
