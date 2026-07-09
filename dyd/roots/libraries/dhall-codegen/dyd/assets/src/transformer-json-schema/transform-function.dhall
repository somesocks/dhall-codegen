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

let FunctionNode = (s.function.nodeF TransformFragment).Type

let transformFunction
    : FunctionNode -> TransformFragment
    = \(node : FunctionNode) ->
      \(ctx : TransformContext) ->
        let FoldState
            : Type
            = { contains : List s.type, index : Natural, length : Natural }

        let foldInput =
              \(y : FoldState) ->
              \(x : TransformFragment) ->
                let index = y.index

                let length = y.length

                let depth = ctx.depth + 1

                let ctx2 = { depth, index }

                let node = x ctx2

                let contains = y.contains # [ node.result ]

                let index = index + 1

                in  { contains, index, length }

        let foldedInput
            : FoldState
            = { contains = [] : List s.type
              , index = 0
              , length = List/length TransformFragment node.props.input
              }

        let foldedInput =
              List/foldLeft
                TransformFragment
                node.props.input
                FoldState
                foldInput
                foldedInput

        let foldTo =
              \(y : FoldState) ->
              \(x : TransformFragment) ->
                let index = y.index

                let length = y.length

                let depth = ctx.depth + 1

                let ctx2 = { depth, index }

                let node = x ctx2

                let contains = y.contains # [ node.result ]

                let index = index + 1

                in  { contains, index, length }

        let foldedOutput
            : FoldState
            = { contains = [] : List s.type
              , index = 0
              , length = List/length TransformFragment node.props.output
              }

        let foldedOutput =
              List/foldLeft
                TransformFragment
                node.props.output
                FoldState
                foldTo
                foldedOutput

        let input =
              s.tuple.from
                s.tuple.props::{ values = foldedInput.contains }
                s.tuple.meta::{=}

        let output =
              s.tuple.from
                s.tuple.props::{ values = foldedOutput.contains }
                s.tuple.meta::{=}

        let result =
              s.record.from
                s.record.props::{
                , required = toMap
                    { kind =
                        s.text.from
                          s.text.props::{
                          , variant = s.text.variants.literal "function"
                          }
                          s.text.meta::{=}
                    , input
                    , output
                    }
                }
                s.record.meta::{=}

        in  { result }

in  transformFunction
