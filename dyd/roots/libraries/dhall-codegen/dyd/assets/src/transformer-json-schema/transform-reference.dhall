let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let transformReference
    : s.reference.node.Type -> TransformFragment
    = \(x : s.reference.node.Type) ->
      \(ctx : TransformContext) ->
        let result = s.reference.from x.props x.meta in { result }

in  transformReference
