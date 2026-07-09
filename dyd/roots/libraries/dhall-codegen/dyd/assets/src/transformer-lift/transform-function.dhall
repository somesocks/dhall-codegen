let Natural/greaterThan = ../prelude/Natural/greaterThan.dhall

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

let FunctionNode = (s.function.nodeF TransformFragment).Type

let transformFunction
    : FunctionNode -> TransformFragment
    = \(x : FunctionNode) ->
      \(ctx : TransformContext) ->
        let FoldState
            : Type
            = { contains : List s.type
              , lifted : List s.root.type
              , index : Natural
              , length : Natural
              }

        let foldInput =
              \(y : FoldState) ->
              \(x : TransformFragment) ->
                let index = y.index

                let length = y.length

                let depth = ctx.depth + 1

                let altName =
                          ctx.altName
                      ++  ctx.options.nameSegmentTransformer "input"
                      ++  ( if    Natural/greaterThan length 1
                            then  Natural/show index
                            else  ""
                          )

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

                let contains = y.contains # [ result ]

                let lifted = y.lifted # node.lifted

                let index = index + 1

                in  { contains, lifted, index, length }

        let foldedInput
            : FoldState
            = { contains = [] : List s.type
              , lifted = [] : List s.root.type
              , index = 0
              , length = List/length TransformFragment x.props.input
              }

        let foldedInput =
              List/foldLeft
                TransformFragment
                x.props.input
                FoldState
                foldInput
                foldedInput

        let foldOutput =
              \(y : FoldState) ->
              \(x : TransformFragment) ->
                let index = y.index

                let length = y.length

                let depth = ctx.depth + 1

                let altName =
                          ctx.altName
                      ++  ctx.options.nameSegmentTransformer "output"
                      ++  ( if    Natural/greaterThan length 1
                            then  Natural/show index
                            else  ""
                          )

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

                let contains = y.contains # [ result ]

                let lifted = y.lifted # node.lifted

                let index = index + 1

                in  { contains, lifted, index, length }

        let foldedOutput
            : FoldState
            = { contains = [] : List s.type
              , lifted = [] : List s.root.type
              , index = 0
              , length = List/length TransformFragment x.props.output
              }

        let foldedOutput =
              List/foldLeft
                TransformFragment
                x.props.output
                FoldState
                foldOutput
                foldedOutput

        let result =
              s.function.from
                { input = foldedInput.contains
                , output = foldedOutput.contains
                , variant = x.props.variant
                }
                x.meta

        let result = TransformNodeResult.required result

        let lifted = foldedInput.lifted # foldedOutput.lifted

        in  { result, lifted }

in  transformFunction
