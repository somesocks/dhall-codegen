let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.map.from
        s.map.props::{
        , keys = s.text.from s.text.props::{=} s.text.meta::{=}
        , values = s.text.from s.text.props::{=} s.text.meta::{=}
        }
        s.map.meta::{ description = Some "a map" }

let testSchema2 =
      s.map.from
        s.map.props::{
        , keys = s.text.from s.text.props::{=} s.text.meta::{=}
        , values = s.text.from s.text.props::{=} s.text.meta::{=}
        , variant = s.map.variants.record
        }
        s.map.meta::{ description = Some "a map-like record" }

let testSchema3 =
      s.map.from
        s.map.props::{
        , keys = s.text.from s.text.props::{=} s.text.meta::{=}
        , values =
            s.map.from
              s.map.props::{
              , keys = s.text.from s.text.props::{=} s.text.meta::{=}
              , values = s.text.from s.text.props::{=} s.text.meta::{=}
              }
              s.map.meta::{ description = Some "a map inside a map" }
        }
        s.map.meta::{ description = Some "a map" }

let testSchema4 =
      s.map.from
        s.map.props::{
        , keys =
            s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{ description = Some "a keys record inside a map" }
        , values =
            s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{
              , description = Some "a values record inside a map"
              }
        }
        s.map.meta::{ description = Some "a map" }

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "MapTest${Natural/show index}"
          , description = Some "map test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
