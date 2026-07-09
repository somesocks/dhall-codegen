let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let OptionalNode = (s.optional.nodeF TransformFragment).Type

let transformOptional
    : OptionalNode -> TransformFragment
    = \(node : OptionalNode) ->
      \(ctx : TransformContext) ->
        let ctx2 = { depth = ctx.depth + 1, index = 0 }

        let value = node.props.value ctx2

        let result = s.optional.from { value = value.result } node.meta

        in  { result }

in  transformOptional
