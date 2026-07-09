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

let MapNode = (s.map.nodeF TransformFragment).Type

let transformMap
    : MapNode -> TransformFragment
    = \(node : MapNode) ->
      \(ctx : TransformContext) ->
        let ctxKeys =
              { depth = ctx.depth + 1
              , index = 0
              , altName =
                  ctx.altName ++ ctx.options.nameSegmentTransformer "Keys"
              , options = ctx.options
              }

        let ctxValues =
              { depth = ctx.depth + 1
              , index = 0
              , altName =
                  ctx.altName ++ ctx.options.nameSegmentTransformer "Values"
              , options = ctx.options
              }

        let keys = node.props.keys ctxKeys

        let values = node.props.values ctxValues

        let lifted = keys.lifted # values.lifted

        let keys =
              merge
                { optional =
                    \(result : s.type) ->
                      s.optional.from
                        s.optional.props::{ value = result }
                        s.optional.meta::{=}
                , required = \(result : s.type) -> result
                }
                keys.result

        let values =
              merge
                { optional =
                    \(result : s.type) ->
                      s.optional.from
                        s.optional.props::{ value = result }
                        s.optional.meta::{=}
                , required = \(result : s.type) -> result
                }
                values.result

        let result =
              s.map.from
                { keys, values, variant = node.props.variant }
                node.meta

        let result = TransformNodeResult.required result

        in  { result, lifted }

in  transformMap
