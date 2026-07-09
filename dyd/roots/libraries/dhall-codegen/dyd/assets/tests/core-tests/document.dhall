let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let def =
      Document::{
      , headers = [] : List Text
      , schemas =
            ./schemas-any.dhall
          # ./schemas-boolean.dhall
          # ./schemas-number.dhall
          # ./schemas-text.dhall
          # ./schemas-time.dhall
          # ./schemas-reference.dhall
          # ./schemas-optional.dhall
          # ./schemas-list.dhall
          # ./schemas-set.dhall
          # ./schemas-map.dhall
          # ./schemas-oneOf.dhall
          # ./schemas-allOf.dhall
          # ./schemas-tuple.dhall
          # ./schemas-record.dhall
          # ./schemas-function.dhall
      }

in  def
