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

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let FunctionNode = (Schema.function.nodeF RenderFragment).Type

let renderFunctionOutputZero
    : FunctionNode -> RenderContext -> {} -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(_ : {}) ->
        let return =
              merge
                { none = "void", async = "Promise<void>" }
                node.props.variant

        let expression = renderPrefix ctx ++ return

        in  expression

let renderFunctionOutputOne
    : FunctionNode -> RenderContext -> RenderFragment -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(output : RenderFragment) ->
        let header =
              merge
                { none = "", async = renderPrefix ctx ++ "Promise<" }
                node.props.variant

        let ctx2 =
              merge
                { none = ctx, async = ctx // { depth = ctx.depth + 1 } }
                node.props.variant

        let body = (output ctx2).expression

        let footer =
              merge
                { none = "", async = renderPrefix ctx ++ ">" }
                node.props.variant

        let expression = header ++ body ++ footer

        in  expression

let renderFunctionOutputMany
    : FunctionNode -> RenderContext -> List RenderFragment -> Text
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
      \(output : List RenderFragment) ->
        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header =
              merge
                { none = renderPrefix ctx ++ "["
                , async = renderPrefix ctx ++ "Promise<["
                }
                node.props.variant

        let renderBodyLine = \(x : RenderFragment) -> (x ctx2).expression

        let body = List/map RenderFragment Text renderBodyLine output

        let body = Text/concatSep "," body

        let footer =
              merge
                { none = renderPrefix ctx ++ "]"
                , async = renderPrefix ctx ++ "]>"
                }
                node.props.variant

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

let renderFunction
    : FunctionNode -> RenderFragment
    = \(node : FunctionNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let ctx3 = ctx // { depth = ctx.depth + 2 }

        let inputHeader = renderPrefix ctx ++ "("

        let renderChild =
              \(index : Natural) ->
              \(x : RenderFragment) ->
                let child = x ctx3

                let arg = renderPrefix ctx2 ++ "x${Natural/show index} :"

                in  arg ++ child.expression

        let inputBody =
              List/mapWithIndex RenderFragment Text renderChild node.props.input

        let inputBody = Text/concatSep "," inputBody

        let inputFooter = renderPrefix ctx ++ ") => "

        let ouput = renderFunctionOutput node ctx

        let definition = inputHeader ++ inputBody ++ inputFooter ++ ouput

        let expression = description ++ definition

        in  { expression }

in  renderFunction
