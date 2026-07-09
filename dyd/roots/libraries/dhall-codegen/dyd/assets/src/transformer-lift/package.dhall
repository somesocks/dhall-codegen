let Natural/greaterThan = ../prelude/Natural/greaterThan.dhall

let List/foldLeft = ../prelude/List/foldLeft.dhall

let Text/snakeCase = ../utils/Text/snakeCase.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let TransformContext = common.TransformContext

let TransformOptions = common.TransformOptions

let TransformNodeResult = common.TransformNodeResult

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let transformSchema = ./transform-schema.dhall

let transformDocument
    : TransformOptions -> Transformer
    = \(options : TransformOptions) ->
      \(x : Document.Type) ->
        let FoldState
            : Type
            = { schemas : List s.root.type
              , index : Natural
              , options : TransformOptions
              }

        let _fold =
              \(y : FoldState) ->
              \(x : s.root.type) ->
                let index = y.index

                let transformed =
                      transformSchema
                        x.contains
                        { index
                        , depth = 0
                        , altName = x.meta.name
                        , options = y.options
                        }

                let lifted = transformed.lifted

                let result =
                      merge
                        { optional =
                            \(result : s.type) ->
                              s.optional.from
                                s.optional.props::{ value = result }
                                s.optional.meta::{=}
                        , required = \(result : s.type) -> result
                        }
                        transformed.result

                let schemas = y.schemas # lifted # [ s.root.from result x.meta ]

                let index = index + 1

                in  { schemas, index, options = y.options }

        let folded
            : FoldState
            = { schemas = [] : List s.root.type, index = 0, options }

        let folded = List/foldLeft s.root.type x.schemas FoldState _fold folded

        let result = x // { schemas = folded.schemas }

        in  result

let options =
      { Type = TransformOptions
      , default.nameSegmentTransformer = Text/snakeCase
      , default.liftOneOf = False
      }

in  { transform = transformDocument, options }
