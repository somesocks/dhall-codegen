let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.time.from s.time.props::{=} s.time.meta::{=}

let testSchema2 =
      s.time.from
        s.time.props::{=}
        s.time.meta::{ description = Some "comment" }

let schemas = [ testSchema1, testSchema2 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "TimeTest${Natural/show index}"
          , description = Some "time test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
