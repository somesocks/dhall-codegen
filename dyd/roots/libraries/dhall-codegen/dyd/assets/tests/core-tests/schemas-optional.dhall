let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.optional.from
        s.optional.props::{
        , value = s.text.from s.text.props::{=} s.text.meta::{=}
        }
        s.optional.meta::{ description = Some "an optional" }

let testSchema2 =
      s.optional.from
        s.optional.props::{
        , value =
            s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{=}
        }
        s.optional.meta::{ description = Some "an optional record" }

let testSchema3 =
      s.optional.from
        s.optional.props::{
        , value =
            s.optional.from
              s.optional.props::{
              , value = s.text.from s.text.props::{=} s.text.meta::{=}
              }
              s.optional.meta::{
              , description = Some "an optional in an optional"
              }
        }
        s.optional.meta::{ description = Some "an optional" }

let schemas = [ testSchema1, testSchema2, testSchema3 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "OptionalTest${Natural/show index}"
          , description = Some "optional test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
