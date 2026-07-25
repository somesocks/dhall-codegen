let List/foldLeft = ../prelude/List/foldLeft.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Transformer = Grammar.Transformer

let Schema = Grammar.Schema

let s = Schema

let transformSchema = ./transform-schema.dhall

let transformDocument
    : Transformer
    = \(document : Document.Type) ->
        let FoldState
            : Type
            = { schemas : List s.root.type, index : Natural }

        let transformRoot =
              \(state : FoldState) ->
              \(root : s.root.type) ->
                let transformed = transformSchema root.contains { index = state.index, depth = 0 }

                in  { schemas = state.schemas # [ s.root.from transformed.result root.meta ]
                    , index = state.index + 1
                    }

        let initial : FoldState = { schemas = [] : List s.root.type, index = 0 }

        let transformed =
              List/foldLeft s.root.type document.schemas FoldState transformRoot initial

        in  document // { schemas = transformed.schemas }

in  { transform = transformDocument }
