let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.any.from s.any.props::{=} s.any.meta::{=}

let testSchema2 =
      s.any.from
        s.any.props::{ variant = s.any.variants.permissive }
        s.any.meta::{=}

let testSchema3 =
      s.any.from s.any.props::{=} s.any.meta::{ description = Some "comment" }

let testSchema4 =
      s.any.from
        s.any.props::{=}
        s.any.meta::{
        , description = Some
            ''
            multi-line
            comment''
        }

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "AnyTest${Natural/show index}"
          , description = Some "any test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
