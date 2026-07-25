let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let PersonReference =
      s.reference.from s.reference.props::{ to = "Person" } s.reference.meta::{=}

let Person =
      s.record.from
        s.record.props::{
        , required = toMap
            { appointment_time =
                s.text.from
                  s.text.props::{ variant = s.text.variants.isoTime }
                  s.text.meta::{ description = Some "RFC 3339 time" }
            , binary_data =
                s.text.from
                  s.text.props::{ variant = s.text.variants.base64 }
                  s.text.meta::{ description = Some "RFC 4648 Base64" }
            , birth_date =
                s.text.from
                  s.text.props::{ variant = s.text.variants.isoDate }
                  s.text.meta::{ description = Some "ISO 8601 calendar date" }
            , created_at =
                s.text.from
                  s.text.props::{ variant = s.text.variants.isoDateTime }
                  s.text.meta::{ description = Some "RFC 3339 date-time" }
            , name =
                s.text.from
                  s.text.props::{=}
                  s.text.meta::{ description = Some "full name" }
            , retention_period =
                s.text.from
                  s.text.props::{ variant = s.text.variants.isoDuration }
                  s.text.meta::{ description = Some "ISO 8601 duration" }
            , date_of_birth =
                s.time.from
                  s.time.props::{ variant = s.time.variants.date }
                  s.time.meta::{ description = Some "date of birth" }
            , id =
                s.text.from
                  s.text.props::{ variant = s.text.variants.uuid }
                  s.text.meta::{ description = Some "RFC 4122 UUID" }
            , phone_number =
                s.text.from
                  s.text.props::{ variant = s.text.variants.e164 }
                  s.text.meta::{ description = Some "E.164 telephone number" }
            , source_ip =
                s.text.from
                  s.text.props::{ variant = s.text.variants.ipv4 }
                  s.text.meta::{ description = Some "IPv4 address" }
            , token =
                s.text.from
                  s.text.props::{ variant = s.text.variants.base64url }
                  s.text.meta::{ description = Some "RFC 4648 Base64url" }
            , destination_ip =
                s.text.from
                  s.text.props::{ variant = s.text.variants.ipv6 }
                  s.text.meta::{ description = Some "IPv6 address" }
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
