let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let PersonReference =
      s.reference.from s.reference.props::{ to = "Person" } s.reference.meta::{=}

let Person =
      s.record.from
        s.record.props::{
        , required = toMap
            { name =
                s.text.from
                  s.text.props::{=}
                  s.text.meta::{ description = Some "full name" }
            , date_of_birth =
                s.time.from
                  s.time.props::{=}
                  s.time.meta::{ description = Some "date of birth" }
            , friends =
                s.list.from
                  s.list.props::{ values = PersonReference }
                  s.list.meta::{ description = Some "friends" }
            }
        , optional = toMap
            { contact_email =
                s.text.from
                  s.text.props::{ variant = s.text.variants.email }
                  s.text.meta::{ description = Some "contact email (we might not have this)" }
            }
        }
        s.record.meta::{=}

let Person = s.root.from Person s.root.meta::{ name = "Person" }

let def = Document::{ headers = [] : List Text, schemas = [ Person ] }

in  def
