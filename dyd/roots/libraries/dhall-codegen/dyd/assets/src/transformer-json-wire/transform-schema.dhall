let List/foldLeft = ../prelude/List/foldLeft.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let TransformContext : Type = { index : Natural, depth : Natural }

let TransformNode : Type = { result : s.type }

let TransformFragment : Type = TransformContext -> TransformNode

let transformFragments
    : List TransformFragment -> TransformContext -> List s.type
    = \(fragments : List TransformFragment) ->
      \(ctx : TransformContext) ->
        let FoldState : Type = { values : List s.type, index : Natural }

        let transformFragment =
              \(state : FoldState) ->
              \(fragment : TransformFragment) ->
                let transformed = fragment { depth = ctx.depth + 1, index = state.index }

                in  { values = state.values # [ transformed.result ], index = state.index + 1 }

        let initial : FoldState = { values = [] : List s.type, index = 0 }

        in  (List/foldLeft TransformFragment fragments FoldState transformFragment initial).values

let RecordFoldState
    : Type
    = { required : List { mapKey : Text, mapValue : s.type }
      , optional : List { mapKey : Text, mapValue : s.type }
      , index : Natural
      , ctx : TransformContext
      }

let transformRequiredField =
      \(state : RecordFoldState) ->
      \(field : { mapKey : Text, mapValue : TransformFragment }) ->
        let transformed =
              field.mapValue { depth = state.ctx.depth + 1, index = state.index }

        in  state
              // { required =
                     state.required
                     # [ { mapKey = field.mapKey, mapValue = transformed.result } ]
                 , index = state.index + 1
                 }

let transformOptionalField =
      \(state : RecordFoldState) ->
      \(field : { mapKey : Text, mapValue : TransformFragment }) ->
        let transformed =
              field.mapValue { depth = state.ctx.depth + 1, index = state.index }

        in  state
              // { optional =
                     state.optional
                     # [ { mapKey = field.mapKey, mapValue = transformed.result } ]
                 , index = state.index + 1
                 }

let transformSchemaF
    : s.typeF TransformFragment -> TransformFragment
    = \(layer : s.typeF TransformFragment) ->
      \(ctx : TransformContext) ->
        let transformer =
              merge
                { Any =
                    \(node : s.any.node.Type) ->
                      { result = s.any.from node.props node.meta }
                , Boolean =
                    \(node : s.boolean.node.Type) ->
                      { result = s.boolean.from node.props node.meta }
                , Number =
                    \(node : s.number.node.Type) ->
                      { result = s.number.from node.props node.meta }
                , Text =
                    \(node : s.text.node.Type) ->
                      { result = s.text.from node.props node.meta }
                , Time =
                    \(node : s.time.node.Type) ->
                      let variant =
                            merge
                              { none = s.text.variants.isoDateTime
                              , date = s.text.variants.isoDate
                              , time = s.text.variants.isoTime
                              , duration = s.text.variants.isoDuration
                              }
                              node.props.variant

                      in  { result = s.text.from { variant } node.meta }
                , Reference =
                    \(node : s.reference.node.Type) ->
                      { result = s.reference.from node.props node.meta }
                , Optional =
                    \(node : (s.optional.nodeF TransformFragment).Type) ->
                      let value = node.props.value { depth = ctx.depth + 1, index = 0 }

                      in  { result = s.optional.from { value = value.result } node.meta }
                , List =
                    \(node : (s.list.nodeF TransformFragment).Type) ->
                      let values = node.props.values { depth = ctx.depth + 1, index = 0 }

                      in  { result = s.list.from { values = values.result } node.meta }
                , Set =
                    \(node : (s.set.nodeF TransformFragment).Type) ->
                      let values = node.props.values { depth = ctx.depth + 1, index = 0 }

                      in  { result = s.list.from { values = values.result } node.meta }
                , Map =
                    \(node : (s.map.nodeF TransformFragment).Type) ->
                      let keys = (node.props.keys { depth = ctx.depth + 1, index = 0 }).result

                      let values =
                            (node.props.values { depth = ctx.depth + 1, index = 1 }).result

                      let entry =
                            s.record.from
                              s.record.props::{
                              , required = toMap { key = keys, value = values }
                              }
                              s.record.meta::{=}

                      in  { result = s.list.from { values = entry } node.meta }
                , OneOf =
                    \(node : (s.oneOf.nodeF TransformFragment).Type) ->
                      let options = transformFragments node.props.options ctx

                      in  { result = s.oneOf.from { options } node.meta }
                , AllOf =
                    \(node : (s.allOf.nodeF TransformFragment).Type) ->
                      let options = transformFragments node.props.options ctx

                      in  { result = s.allOf.from { options } node.meta }
                , Tuple =
                    \(node : (s.tuple.nodeF TransformFragment).Type) ->
                      let values = transformFragments node.props.values ctx

                      in  { result = s.tuple.from { values } node.meta }
                , Record =
                    \(node : (s.record.nodeF TransformFragment).Type) ->
                      let initial
                          : RecordFoldState
                          = { required = [] : List { mapKey : Text, mapValue : s.type }
                            , optional = [] : List { mapKey : Text, mapValue : s.type }
                            , index = 0
                            , ctx
                            }

                      let transformedRequired =
                            List/foldLeft
                              { mapKey : Text, mapValue : TransformFragment }
                              node.props.required
                              RecordFoldState
                              transformRequiredField
                              initial

                      let transformed =
                            List/foldLeft
                              { mapKey : Text, mapValue : TransformFragment }
                              node.props.optional
                              RecordFoldState
                              transformOptionalField
                              transformedRequired

                      in  { result =
                              s.record.from
                                { required = transformed.required
                                , optional = transformed.optional
                                , variant = node.props.variant
                                }
                                node.meta
                          }
                , Function =
                    \(node : (s.function.nodeF TransformFragment).Type) ->
                      let input = transformFragments node.props.input ctx

                      let output = transformFragments node.props.output ctx

                      let descriptor =
                            s.record.from
                              s.record.props::{
                              , required = toMap
                                  { kind =
                                      s.text.from
                                        s.text.props::{
                                        , variant = s.text.variants.literal "function"
                                        }
                                        s.text.meta::{=}
                                  , input = s.tuple.from { values = input } s.tuple.meta::{=}
                                  , output = s.tuple.from { values = output } s.tuple.meta::{=}
                                  }
                              }
                              node.meta

                      in  { result = descriptor }
                }
                layer

        in  transformer

let transformSchema = Schema.fold s.typeF TransformFragment transformSchemaF

in  transformSchema
