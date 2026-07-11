let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.number.from s.number.props::{=} s.number.meta::{=}

let testSchema2 =
      s.number.from
        s.number.props::{=}
        s.number.meta::{ description = Some "number" }

let testSchema3 =
      s.number.from
        s.number.props::{ variant = s.number.variants.natural }
        s.number.meta::{ description = Some "natural" }

let testSchema4 =
      s.number.from
        s.number.props::{ variant = s.number.variants.integer }
        s.number.meta::{ description = Some "integer" }

let testSchema5 =
      s.number.from
        s.number.props::{ variant = s.number.variants.decimal }
        s.number.meta::{ description = Some "decimal" }

let schemas =
      [ testSchema1, testSchema2, testSchema3, testSchema4, testSchema5 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "NumberTest${Natural/show index}"
          , description = Some "number test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
