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

let TransformNode = common.TransformNode

let TransformFragment = common.TransformFragment

let transformSchema = ./transform-schema.dhall

let transformDocument
    : Transformer
    = \(x : Document.Type) ->
        let FoldState
            : Type
            = { schemas : List s.root.type, index : Natural }

        let _fold =
              \(y : FoldState) ->
              \(x : s.root.type) ->
                let index = y.index

                let transformed =
                      transformSchema x.contains { index, depth = 0 }

                let schemas =
                      y.schemas # [ s.root.from transformed.result x.meta ]

                let index = index + 1

                in  { schemas, index }

        let folded
            : FoldState
            = { schemas = [] : List s.root.type, index = 0 }

        let folded = List/foldLeft s.root.type x.schemas FoldState _fold folded

        let result = x // { schemas = folded.schemas }

        in  result

in  { transform = transformDocument }
