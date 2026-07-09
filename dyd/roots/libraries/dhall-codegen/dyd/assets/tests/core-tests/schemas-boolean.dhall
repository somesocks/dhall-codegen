let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}

let testSchema2 =
      s.boolean.from
        s.boolean.props::{=}
        s.boolean.meta::{ description = Some "comment" }

let testSchema3 =
      s.boolean.from
        s.boolean.props::{=}
        s.boolean.meta::{
        , description = Some
            ''
            multi-line
            comment''
        }

let schemas = [ testSchema1, testSchema2, testSchema3 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "BooleanTest${Natural/show index}"
          , description = Some "boolean test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
