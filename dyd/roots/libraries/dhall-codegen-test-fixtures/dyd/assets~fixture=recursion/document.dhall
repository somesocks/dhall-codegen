let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Person =
      s.record.from
        s.record.props::{
        , required = toMap
            { name = s.text.from s.text.props::{=} s.text.meta::{=}
            , parents =
                s.set.from
                  s.set.props::{
                  , values =
                      s.reference.from
                        s.reference.props::{ to = "Person" }
                        s.reference.meta::{=}
                  }
                  s.set.meta::{=}
            }
        }
        s.record.meta::{=}

let Person = s.root.from Person s.root.meta::{ name = "Person" }

let def = Document::{ headers = [] : List Text, schemas = [ Person ] }

in  def
