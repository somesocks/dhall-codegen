let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let transformAny = ./transform-any.dhall

let transformBoolean = ./transform-boolean.dhall

let transformNumber = ./transform-number.dhall

let transformText = ./transform-text.dhall

let transformTime = ./transform-time.dhall

let transformReference = ./transform-reference.dhall

let transformOptional = ./transform-optional.dhall

let transformList = ./transform-list.dhall

let transformSet = ./transform-set.dhall

let transformMap = ./transform-map.dhall

let transformOneOf = ./transform-one-of.dhall

let transformAllOf = ./transform-all-of.dhall

let transformTuple = ./transform-tuple.dhall

let transformRecord = ./transform-record.dhall

let transformFunction = ./transform-function.dhall

let transformSchema
    : s.typeF TransformFragment -> TransformFragment
    = \(layer : s.typeF TransformFragment) ->
      \(ctx : TransformContext) ->
        let renderer =
              merge
                { Any = transformAny
                , Boolean = transformBoolean
                , Number = transformNumber
                , Text = transformText
                , Time = transformTime
                , Reference = transformReference
                , Optional = transformOptional
                , List = transformList
                , Set = transformSet
                , Map = transformMap
                , OneOf = transformOneOf
                , AllOf = transformAllOf
                , Tuple = transformTuple
                , Record = transformRecord
                , Function = transformFunction
                }
                layer

        in  renderer ctx

let transformSchema = Schema.fold s.typeF TransformFragment transformSchema

in  transformSchema
