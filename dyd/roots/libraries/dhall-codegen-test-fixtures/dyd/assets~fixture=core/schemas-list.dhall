let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
      s.list.from
        s.list.props::{
        , values = s.text.from s.text.props::{=} s.text.meta::{=}
        }
        s.list.meta::{ description = Some "a list" }

let testSchema2 =
      s.list.from
        s.list.props::{
        , values =
            s.list.from
              s.list.props::{
              , values = s.text.from s.text.props::{=} s.text.meta::{=}
              }
              s.list.meta::{ description = Some "a list inside a list" }
        }
        s.list.meta::{ description = Some "a list" }

let testSchema3 =
      s.list.from
        s.list.props::{
        , values =
            s.record.from
              s.record.props::{
              , required = toMap
                  { foo = s.text.from s.text.props::{=} s.text.meta::{=} }
              }
              s.record.meta::{ description = Some "a record inside a list" }
        }
        s.list.meta::{ description = Some "a list" }

let schemas = [ testSchema1, testSchema2, testSchema3 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "ListTest${Natural/show index}"
          , description = Some "list test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
