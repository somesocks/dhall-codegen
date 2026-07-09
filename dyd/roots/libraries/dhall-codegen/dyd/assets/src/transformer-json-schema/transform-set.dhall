let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let SetNode = (s.set.nodeF TransformFragment).Type

let transformSet
    : SetNode -> TransformFragment
    = \(node : SetNode) ->
      \(ctx : TransformContext) ->
        let ctx2 = { depth = ctx.depth + 1, index = 0 }

        let values = node.props.values ctx2

        let result =
              s.set.from
                { values = values.result, variant = node.props.variant }
                node.meta

        in  { result }

in  transformSet
