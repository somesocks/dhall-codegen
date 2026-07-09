let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let personSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { name = s.text.from s.text.props::{=} s.text.meta::{=}
            , age =
                s.number.from
                  s.number.props::{ variant = s.number.variants.natural }
                  s.number.meta::{=}
            , deceased = s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
            }
        }
        s.record.meta::{=}

let personSchema = s.root.from personSchema s.root.meta::{ name = "Person" }

let peopleSchema =
      s.list.from
        s.list.props::{
        , values =
            s.reference.from
              s.reference.props::{ to = "Person" }
              s.reference.meta::{
              , description = Some "reference to person type"
              }
        }
        s.list.meta::{=}

let peopleSchema = s.root.from peopleSchema s.root.meta::{ name = "People" }

in  [ personSchema, peopleSchema ]
