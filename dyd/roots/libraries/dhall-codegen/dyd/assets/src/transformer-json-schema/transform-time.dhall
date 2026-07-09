let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let transformTime
    : s.time.node.Type -> TransformFragment
    = \(node : s.time.node.Type) ->
      \(ctx : TransformContext) ->
        let result = s.time.from node.props node.meta in { result }

in  transformTime
