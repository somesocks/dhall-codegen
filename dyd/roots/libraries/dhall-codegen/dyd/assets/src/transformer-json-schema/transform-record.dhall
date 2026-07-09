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

let RecordNode = (s.record.nodeF TransformFragment).Type

let RecordFoldState
    : Type
    = { required : List { mapKey : Text, mapValue : s.type }
      , optional : List { mapKey : Text, mapValue : s.type }
      , index : Natural
      , ctx : TransformContext
      }

let transformRecordRequired =
      \(state : RecordFoldState) ->
      \(x : { mapKey : Text, mapValue : TransformFragment }) ->
        let ctx = state.ctx

        let index = state.index

        let depth = ctx.depth + 1

        let ctx2 = { index, depth }

        let node = x.mapValue ctx2

        let required =
              state.required # [ { mapKey = x.mapKey, mapValue = node.result } ]

        let optional = state.optional

        let index = index + 1

        in  { ctx, required, optional, index }

let transformRecordOptional =
      \(state : RecordFoldState) ->
      \(x : { mapKey : Text, mapValue : TransformFragment }) ->
        let ctx = state.ctx

        let index = state.index

        let depth = ctx.depth + 1

        let ctx2 = { index, depth }

        let node = x.mapValue ctx2

        let required = state.required

        let optional =
              state.optional # [ { mapKey = x.mapKey, mapValue = node.result } ]

        let index = index + 1

        in  { ctx, required, optional, index }

let transformRecord
    : RecordNode -> TransformFragment
    = \(x : RecordNode) ->
      \(ctx : TransformContext) ->
        let folded
            : RecordFoldState
            = { required = [] : List { mapKey : Text, mapValue : s.type }
              , optional = [] : List { mapKey : Text, mapValue : s.type }
              , index = 0
              , ctx
              }

        let folded =
              List/foldLeft
                { mapKey : Text, mapValue : TransformFragment }
                x.props.required
                RecordFoldState
                transformRecordRequired
                folded

        let folded =
              List/foldLeft
                { mapKey : Text, mapValue : TransformFragment }
                x.props.optional
                RecordFoldState
                transformRecordOptional
                folded

        let required = folded.required

        let optional = folded.optional

        let variant = x.props.variant

        let result = s.record.from { required, optional, variant } x.meta

        in  { result }

in  transformRecord
