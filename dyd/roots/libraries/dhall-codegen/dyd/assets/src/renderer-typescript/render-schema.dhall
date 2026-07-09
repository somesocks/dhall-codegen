let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderAny = ./render-any.dhall

let renderBoolean = ./render-boolean.dhall

let renderNumber = ./render-number.dhall

let renderText = ./render-text.dhall

let renderTime = ./render-time.dhall

let renderReference = ./render-reference.dhall

let renderOptional = ./render-optional.dhall

let renderList = ./render-list.dhall

let renderSet = ./render-set.dhall

let renderMap = ./render-map.dhall

let renderOneOf = ./render-one-of.dhall

let renderAllOf = ./render-all-of.dhall

let renderTuple = ./render-tuple.dhall

let renderRecord = ./render-record.dhall

let renderFunction = ./render-function.dhall

let renderSchema
    : s.typeF RenderFragment -> RenderFragment
    = \(layer : s.typeF RenderFragment) ->
      \(ctx : RenderContext) ->
        let renderer =
              merge
                { Any = renderAny
                , Boolean = renderBoolean
                , Number = renderNumber
                , Text = renderText
                , Time = renderTime
                , Reference = renderReference
                , Optional = renderOptional
                , List = renderList
                , Set = renderSet
                , Map = renderMap
                , OneOf = renderOneOf
                , AllOf = renderAllOf
                , Tuple = renderTuple
                , Record = renderRecord
                , Function = renderFunction
                }
                layer

        in  renderer ctx

let renderSchema = s.fold s.typeF RenderFragment renderSchema

in  renderSchema
