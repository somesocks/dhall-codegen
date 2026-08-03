let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ./dhall-codegen/grammar.dhall

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

let testSchema4 =
      s.optional.from
        s.optional.props::{
        , value =
            s.tuple.from
              s.tuple.props::{
              , values =
                [ s.text.from s.text.props::{=} s.text.meta::{=}
                , s.number.from
                    s.number.props::{ variant = s.number.variants.natural }
                    s.number.meta::{=}
                ]
              }
              s.tuple.meta::{=}
        }
        s.optional.meta::{ description = Some "an optional tuple" }

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4 ]

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
