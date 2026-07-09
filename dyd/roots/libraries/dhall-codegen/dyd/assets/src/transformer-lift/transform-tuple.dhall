let List/foldLeft = ../prelude/List/foldLeft.dhall

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

let TupleNode = (s.tuple.nodeF TransformFragment).Type

let transformTuple
    : TupleNode -> TransformFragment
    = \(x : TupleNode) ->
      \(ctx : TransformContext) ->
        let FoldState
            : Type
            = { values : List s.type
              , lifted : List s.root.type
              , index : Natural
              }

        let foldValues =
              \(state : FoldState) ->
              \(x : TransformFragment) ->
                let index = state.index

                let depth = ctx.depth + 1

                let altName =
                          ctx.altName
                      ++  ctx.options.nameSegmentTransformer
                            "Value${Natural/show index}"

                let ctx2 = { depth, index, altName, options = ctx.options }

                let node = x ctx2

                let result =
                      merge
                        { optional =
                            \(result : s.type) ->
                              s.optional.from
                                s.optional.props::{ value = result }
                                s.optional.meta::{=}
                        , required = \(result : s.type) -> result
                        }
                        node.result

                let values = state.values # [ result ]

                let lifted = state.lifted # node.lifted

                let index = index + 1

                in  { values, lifted, index }

        let folded
            : FoldState
            = { values = [] : List s.type
              , lifted = [] : List s.root.type
              , index = 0
              }

        let folded =
              List/foldLeft
                TransformFragment
                x.props.values
                FoldState
                foldValues
                folded

        let values = folded.values

        let result = s.tuple.from { values } x.meta

        let result = TransformNodeResult.required result

        let lifted = folded.lifted

        in  { result, lifted }

in  transformTuple
