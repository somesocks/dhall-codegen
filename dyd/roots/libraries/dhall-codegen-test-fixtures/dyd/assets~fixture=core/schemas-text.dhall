let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.text.from s.text.props::{=} s.text.meta::{=}

let testSchema2 =
      s.text.from s.text.props::{=} s.text.meta::{ description = Some "text" }

let testSchema3 =
      s.text.from
        s.text.props::{ variant = s.text.variants.email }
        s.text.meta::{ description = Some "email" }

let testSchema4 =
      s.text.from
        s.text.props::{ variant = s.text.variants.url }
        s.text.meta::{ description = Some "url" }

let testSchema5 =
      s.text.from
        s.text.props::{ variant = s.text.variants.literal "foo" }
        s.text.meta::{ description = Some "text literal" }

let schemas =
      [ testSchema1, testSchema2, testSchema3, testSchema4, testSchema5 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "TextTest${Natural/show index}"
          , description = Some "text test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
