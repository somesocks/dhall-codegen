let List/foldLeft = ../prelude/List/foldLeft.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let TupleNode = (s.tuple.nodeF TransformFragment).Type

let transformTuple
    : TupleNode -> TransformFragment
    = \(x : TupleNode) ->
      \(ctx : TransformContext) ->
        let FoldState
            : Type
            = { contains : List s.type, index : Natural }

        let foldContains =
              \(y : FoldState) ->
              \(x : TransformFragment) ->
                let index = y.index

                let depth = ctx.depth + 1

                let ctx2 = { depth, index }

                let node = x ctx2

                let contains = y.contains # [ node.result ]

                let index = index + 1

                in  { contains, index }

        let folded
            : FoldState
            = { contains = [] : List s.type, index = 0 }

        let folded =
              List/foldLeft
                TransformFragment
                x.props.values
                FoldState
                foldContains
                folded

        let values = folded.contains

        let result = s.tuple.from { values } x.meta

        in  { result }

in  transformTuple
