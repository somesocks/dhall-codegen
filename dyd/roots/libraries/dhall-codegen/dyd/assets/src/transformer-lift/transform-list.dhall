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

let ListNode = (s.list.nodeF TransformFragment).Type

let transformList
    : ListNode -> TransformFragment
    = \(node : ListNode) ->
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

        let result = s.list.from { values } node.meta

        let result = TransformNodeResult.required result

        in  { result, lifted }

in  transformList
