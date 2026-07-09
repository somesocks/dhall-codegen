let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.set.from
        s.set.props::{ values = s.text.from s.text.props::{=} s.text.meta::{=} }
        s.set.meta::{ description = Some "a set" }

let testSchema2 =
      s.set.from
        s.set.props::{
        , values = s.text.from s.text.props::{=} s.text.meta::{=}
        , variant = s.set.variants.list
        }
        s.set.meta::{ description = Some "a set-like list" }

let testSchema3 =
      s.set.from
        s.set.props::{
        , values =
            s.set.from
              s.set.props::{
              , values = s.text.from s.text.props::{=} s.text.meta::{=}
              }
              s.set.meta::{ description = Some "a set inside a set" }
        }
        s.set.meta::{ description = Some "a set" }

let testSchema4 =
      s.set.from
        s.set.props::{
        , values =
            s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{ description = Some "a record inside a set" }
        }
        s.set.meta::{ description = Some "a set" }

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "SetTest${Natural/show index}"
          , description = Some "set test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
