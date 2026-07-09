let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let TransformOptions =
      { nameSegmentTransformer : Text -> Text, liftOneOf : Bool }

let TransformContext
    : Type
    = { altName : Text
      , index : Natural
      , depth : Natural
      , options : TransformOptions
      }

let TransformNodeResult
    : Type
    = < optional : s.type | required : s.type >

let TransformNode
    : Type
    = { result : TransformNodeResult, lifted : List s.root.type }

let TransformFragment
    : Type
    = TransformContext -> TransformNode

in  { TransformContext
    , TransformOptions
    , TransformNodeResult
    , TransformNode
    , TransformFragment
    }
