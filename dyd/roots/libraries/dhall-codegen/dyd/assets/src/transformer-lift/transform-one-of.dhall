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

let OneOfNode = (s.oneOf.nodeF TransformFragment).Type

let transformOneOf
    : OneOfNode -> TransformFragment
    = \(node : OneOfNode) ->
      \(ctx : TransformContext) ->
        let FoldState
            : Type
            = { options : List s.type
              , lifted : List s.root.type
              , index : Natural
              , optional : Bool
              }

        let foldOptions =
              \(state : FoldState) ->
              \(x : TransformFragment) ->
                let index = state.index

                let depth = ctx.depth + 1

                let altName =
                          ctx.altName
                      ++  ctx.options.nameSegmentTransformer
                            "Option${Natural/show index}"

                let ctx2 = { depth, index, altName, options = ctx.options }

                let node = x ctx2

                let lifted = state.lifted # node.lifted

                let result =
                      merge
                        { optional = \(result : s.type) -> result
                        , required = \(result : s.type) -> result
                        }
                        node.result

                let optional =
                      merge
                        { optional = \(result : s.type) -> True
                        , required = \(result : s.type) -> False
                        }
                        node.result

                let optional = optional || state.optional

                let options = state.options # [ result ]

                let index = index + 1

                in  { options, lifted, index, optional }

        let folded
            : FoldState
            = { options = [] : List s.type
              , lifted = [] : List s.root.type
              , index = 0
              , optional = False
              }

        let folded =
              List/foldLeft
                TransformFragment
                node.props.options
                FoldState
                foldOptions
                folded

        let options = folded.options

        let resultSchema = s.oneOf.from { options } node.meta

        let base = Natural/isZero ctx.depth

        let shouldLift =
              if    base
              then  False
              else  ctx.options.liftOneOf

        let lifted =
              if    shouldLift
              then  folded.lifted # [ s.root.from resultSchema s.root.meta::{ name = ctx.altName } ]
              else  folded.lifted

        let resultSchema =
              if    shouldLift
              then  s.reference.from { to = ctx.altName } node.meta
              else  resultSchema

        let result =
              if    folded.optional
              then  TransformNodeResult.optional resultSchema
              else  TransformNodeResult.required resultSchema

        in  { result, lifted }

in  transformOneOf
