let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNodeResult = common.TransformNodeResult

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let OptionalNode = (s.optional.nodeF TransformFragment).Type

let transformOptional
    : OptionalNode -> TransformFragment
    = \(node : OptionalNode) ->
      \(ctx : TransformContext) ->
        let ctx2 =
              { depth = ctx.depth + 1
              , index = 0
              , altName =
                  ctx.altName ++ ctx.options.nameSegmentTransformer "Value"
              , options = ctx.options
              }

        let value = node.props.value ctx2

        let result =
              merge
                { optional =
                    \(result : s.type) -> TransformNodeResult.optional result
                , required =
                    \(result : s.type) -> TransformNodeResult.optional result
                }
                value.result

        let lifted = value.lifted

        in  { result, lifted }

in  transformOptional
