let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let MapNode = (s.map.nodeF TransformFragment).Type

let transformMap
    : MapNode -> TransformFragment
    = \(node : MapNode) ->
      \(ctx : TransformContext) ->
        let ctxKeys = { depth = ctx.depth + 1, index = 0 }

        let ctxValues = { depth = ctx.depth + 1, index = 0 }

        let keys = (node.props.keys ctxKeys).result

        let values = (node.props.values ctxValues).result

        let pair =
              s.record.from
                s.record.props::{
                , required = toMap { key = keys, value = values }
                }
                s.record.meta::{=}

        let result = s.list.from s.list.props::{ values = pair } node.meta

        in  { result }

in  transformMap
