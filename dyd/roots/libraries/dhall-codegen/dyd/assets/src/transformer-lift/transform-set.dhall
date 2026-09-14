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

let materialize = common.materialize

let SetNode = (s.set.nodeF TransformFragment).Type

let transformSet
    : SetNode -> TransformFragment
    = \(node : SetNode) ->
      \(ctx : TransformContext) ->
        let ctx2 =
              { depth = ctx.depth + 1
              , index = 0
              , altName =
                  ctx.altName ++ ctx.options.nameSegmentTransformer "Values"
              , options = ctx.options
              }

        let values = node.props.values ctx2

        let lifted = values.lifted

        let values = materialize values.result

        let result =
              s.set.from { values, variant = node.props.variant } node.meta

        let result = TransformNodeResult.required result

        in  { result, lifted }

in  transformSet
