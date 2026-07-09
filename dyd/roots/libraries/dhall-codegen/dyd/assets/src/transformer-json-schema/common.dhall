let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let TransformContext
    : Type
    = { altName : Text
      , nameSegmentTransformer : Text -> Text
      , index : Natural
      , depth : Natural
      }

let TransformContext
    : Type
    = { index : Natural, depth : Natural }

let TransformNode = { result : s.type }

let TransformFragment
    : Type
    = TransformContext -> TransformNode

in  { TransformContext, TransformNode, TransformFragment }
