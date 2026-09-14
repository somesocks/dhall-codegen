let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let TransformOptions =
      { nameSegmentTransformer : Text -> Text
      , liftOneOf : Bool
      , collapseOptionalRecordValues : Bool
      }

let TransformContext
    : Type
    = { altName : Text
      , index : Natural
      , depth : Natural
      , options : TransformOptions
      }

let TransformNodeResult
    : Type
    = < optional : s.type
      | required : s.type
      | nullable : s.type
      | nullish : s.type
      >

let materialize
    : TransformNodeResult -> s.type
    = \(result : TransformNodeResult) ->
        merge
          { required = \(value : s.type) -> value
          , optional =
              \(value : s.type) ->
                s.optional.from
                  s.optional.props::{
                  , value
                  , variant = s.optional.variants.optional
                  }
                  s.optional.meta::{=}
          , nullable =
              \(value : s.type) ->
                s.optional.from
                  s.optional.props::{
                  , value
                  , variant = s.optional.variants.nullable
                  }
                  s.optional.meta::{=}
          , nullish =
              \(value : s.type) ->
                s.optional.from
                  s.optional.props::{
                  , value
                  , variant = s.optional.variants.nullish
                  }
                  s.optional.meta::{=}
          }
          result

let recordValue
    : TransformNodeResult -> s.type
    = \(result : TransformNodeResult) ->
        merge
          { required = \(value : s.type) -> value
          , optional = \(value : s.type) -> value
          , nullable =
              \(value : s.type) ->
                s.optional.from
                  s.optional.props::{
                  , value
                  , variant = s.optional.variants.nullable
                  }
                  s.optional.meta::{=}
          , nullish =
              \(value : s.type) ->
                s.optional.from
                  s.optional.props::{
                  , value
                  , variant = s.optional.variants.nullable
                  }
                  s.optional.meta::{=}
          }
          result

let TransformNode
    : Type
    = { result : TransformNodeResult, lifted : List s.root.type }

let TransformFragment
    : Type
    = TransformContext -> TransformNode

in  { TransformContext
    , TransformOptions
    , TransformNodeResult
    , materialize
    , recordValue
    , TransformNode
    , TransformFragment
    }
