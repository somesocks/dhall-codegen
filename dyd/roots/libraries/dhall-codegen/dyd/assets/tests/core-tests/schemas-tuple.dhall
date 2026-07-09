let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
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

let testSchema2 =
      s.tuple.from
        s.tuple.props::{
        , values =
          [ s.text.from s.text.props::{=} s.text.meta::{=}
          , s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{=}
          ]
        }
        s.tuple.meta::{ description = Some "a tuple" }

let testSchema3 =
      s.tuple.from
        s.tuple.props::{
        , values =
          [ s.text.from s.text.props::{=} s.text.meta::{=}
          , s.tuple.from
              s.tuple.props::{
              , values =
                [ s.text.from s.text.props::{=} s.text.meta::{=}
                , s.number.from
                    s.number.props::{ variant = s.number.variants.natural }
                    s.number.meta::{=}
                ]
              }
              s.tuple.meta::{ description = Some "a tuple in a tuple" }
          ]
        }
        s.tuple.meta::{ description = Some "a tuple" }

let schemas = [ testSchema1, testSchema2, testSchema3 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "TupleTest${Natural/show index}"
          , description = Some "tuple test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
