let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.allOf.from
        s.allOf.props::{
        , options =
          [ s.record.from
              s.record.props::{
              , required = toMap
                  { bar = s.number.from s.number.props::{=} s.number.meta::{=} }
              }
              s.record.meta::{=}
          , s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{=}
          ]
        }
        s.allOf.meta::{ description = Some "all of two records" }

let schemas = [ testSchema1 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "AllOfTest${Natural/show index}"
          , description = Some "allOf test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
