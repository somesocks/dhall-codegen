let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let List/zeroOneMany = ../prelude/List/zeroOneMany.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let FunctionNode = (s.function.nodeF RenderFragment).Type

let renderFunctionOutputZero
    : FunctionNode -> RenderContext -> {} -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(_ : {}) ->
        let return =
              merge
                { none = "None", async = "Awaitable[None]" }
                node.props.variant

        let expression = return

        in  expression

let renderFunctionOutputOne
    : FunctionNode -> RenderContext -> RenderFragment -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(output : RenderFragment) ->
        let header =
              merge { none = "", async = "Awaitable[" } node.props.variant

        let ctx2 =
              merge
                { none = ctx, async = ctx // { depth = ctx.depth + 1 } }
                node.props.variant

        let body = (output ctx2).expression

        let footer = merge { none = "", async = "]" } node.props.variant

        let expression = header ++ body ++ footer

        in  expression

let renderFunctionOutputMany
    : FunctionNode -> RenderContext -> List RenderFragment -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(output : List RenderFragment) ->
        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header =
              merge { none = "tuple[", async = "Awaitable[tuple[" } node.props.variant

        let renderBodyLine = \(x : RenderFragment) -> (x ctx2).expression

        let body = List/map RenderFragment Text renderBodyLine output

        let body = Text/concatSep ", " body

        let footer = merge { none = "]", async = "]]" } node.props.variant

        let expression = header ++ body ++ footer

        in  expression

let renderFunctionOutput
    : FunctionNode -> RenderContext -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
        List/zeroOneMany
          RenderFragment
          Text
          (renderFunctionOutputZero node ctx)
          (renderFunctionOutputOne node ctx)
          (renderFunctionOutputMany node ctx)
          node.props.output

let renderFunctionInput
    : FunctionNode -> RenderContext -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let inputHeader = "["

        let renderChild =
              \(index : Natural) ->
              \(x : RenderFragment) ->
                let child = x ctx2 in child.expression

        let inputBody =
              List/mapWithIndex RenderFragment Text renderChild node.props.input

        let inputBody = Text/concatSep ", " inputBody

        let inputFooter = "]"

        let definition = inputHeader ++ inputBody ++ inputFooter

        let expression = definition

        in  expression

let renderFunction
    : FunctionNode -> RenderFragment
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
        let description = ""

        let input = renderFunctionInput node ctx

        let ouput = renderFunctionOutput node ctx

        let definition = "Callable[${input}, ${ouput}]"

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderFunction
