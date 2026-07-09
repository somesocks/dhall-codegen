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

let RecordNode = (s.record.nodeF TransformFragment).Type

let RecordFoldState
    : Type
    = { required : List { mapKey : Text, mapValue : s.type }
      , optional : List { mapKey : Text, mapValue : s.type }
      , lifted : List s.root.type
      , index : Natural
      , ctx : TransformContext
      }

let foldRecordRequiredField =
      \(state : RecordFoldState) ->
      \(x : { mapKey : Text, mapValue : TransformFragment }) ->
        let ctx = state.ctx

        let index = state.index

        let depth = ctx.depth + 1

        let altName = ctx.altName ++ ctx.options.nameSegmentTransformer x.mapKey

        let ctx2 = { index, depth, altName, options = ctx.options }

        let node = x.mapValue ctx2

        let required =
              merge
                { optional = \(result : s.type) -> state.required
                , required =
                    \(result : s.type) ->
                        state.required
                      # [ { mapKey = x.mapKey, mapValue = result } ]
                }
                node.result

        let optional =
              merge
                { optional =
                    \(result : s.type) ->
                        state.optional
                      # [ { mapKey = x.mapKey, mapValue = result } ]
                , required = \(result : s.type) -> state.optional
                }
                node.result

        let lifted = state.lifted # node.lifted

        let index = index + 1

        in  { required, optional, lifted, index, ctx }

let foldRecordOptionalField =
      \(state : RecordFoldState) ->
      \(x : { mapKey : Text, mapValue : TransformFragment }) ->
        let ctx = state.ctx

        let index = state.index

        let depth = ctx.depth + 1

        let altName = ctx.altName ++ ctx.options.nameSegmentTransformer x.mapKey

        let ctx2 = { index, depth, altName, options = ctx.options }

        let node = x.mapValue ctx2

        let required = state.required

        let optional =
              merge
                { optional =
                    \(result : s.type) ->
                        state.optional
                      # [ { mapKey = x.mapKey, mapValue = result } ]
                , required =
                    \(result : s.type) ->
                        state.optional
                      # [ { mapKey = x.mapKey, mapValue = result } ]
                }
                node.result

        let lifted = state.lifted # node.lifted

        let index = index + 1

        in  { required, optional, lifted, index, ctx }

let transformRecord
    : RecordNode -> TransformFragment
    = \(x : RecordNode) ->
      \(ctx : TransformContext) ->
        let folded
            : RecordFoldState
            = { required = [] : List { mapKey : Text, mapValue : s.type }
              , optional = [] : List { mapKey : Text, mapValue : s.type }
              , lifted = [] : List s.root.type
              , index = 0
              , ctx
              }

        let folded =
              List/foldLeft
                { mapKey : Text, mapValue : TransformFragment }
                x.props.required
                RecordFoldState
                foldRecordRequiredField
                folded

        let folded =
              List/foldLeft
                { mapKey : Text, mapValue : TransformFragment }
                x.props.optional
                RecordFoldState
                foldRecordOptionalField
                folded

        let required = folded.required

        let optional = folded.optional

        let variant = x.props.variant

        let result = s.record.from { required, optional, variant } x.meta

        let lifted = folded.lifted

        let baseRecord = Natural/isZero ctx.depth

        let altName = ctx.altName

        let lifted =
              if    baseRecord
              then  lifted
              else    lifted
                    # [ s.root.from result s.root.meta::{ name = altName } ]

        let result =
              if    baseRecord
              then  result
              else  s.reference.from { to = altName } x.meta

        let result = TransformNodeResult.required result

        in  { result, lifted }

in  transformRecord
