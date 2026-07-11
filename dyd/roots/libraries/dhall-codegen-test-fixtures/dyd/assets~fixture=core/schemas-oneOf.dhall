let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.text.from
              s.text.props::{=}
              s.text.meta::{ name = Some "TextValue" }
          , s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{ name = Some "NaturalValue" }
          ]
        }
        s.oneOf.meta::{=}

let testSchema2 =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.text.from
              s.text.props::{=}
              s.text.meta::{ name = Some "TextValue" }
          , s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{ name = Some "NaturalValue" }
          ]
        }
        s.oneOf.meta::{ description = Some "number or string" }

let testSchema3 =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.text.from
              s.text.props::{=}
              s.text.meta::{ name = Some "TextValue" }
          , s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{ name = Some "NaturalValue" }
          , s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.text.from s.text.props::{=} s.text.meta::{=}
                  , bar =
                      s.number.from s.number.props::{=} s.number.meta::{=}
                  }
              }
              s.record.meta::{ name = Some "Details" }
          ]
        }
        s.oneOf.meta::{ description = Some "number or string or record" }

let testSchema4 =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.reference.from
              s.reference.props::{ to = "Foo" }
              s.reference.meta::{ name = Some "FooRef" }
          , s.reference.from
              s.reference.props::{ to = "Bar" }
              s.reference.meta::{ name = Some "BarRef" }
          ]
        }
        s.oneOf.meta::{ description = Some "named references" }

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "OneOfTest${Natural/show index}"
          , description = Some "oneOf test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
