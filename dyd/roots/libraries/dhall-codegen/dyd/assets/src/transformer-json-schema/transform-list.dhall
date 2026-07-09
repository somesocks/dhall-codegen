let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let ListNode = (s.list.nodeF TransformFragment).Type

let transformList
    : ListNode -> TransformFragment
    = \(node : ListNode) ->
      \(ctx : TransformContext) ->
        let ctx2 = { depth = ctx.depth + 1, index = 0 }

        let values = node.props.values ctx2

        let result = s.list.from { values = values.result } node.meta

        in  { result }

in  transformList
