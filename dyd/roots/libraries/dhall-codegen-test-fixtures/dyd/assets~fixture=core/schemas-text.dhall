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

let testSchema6 =
      s.text.from
        s.text.props::{ variant = s.text.variants.isoDateTime }
        s.text.meta::{ description = Some "RFC 3339 date-time" }

let testSchema7 =
      s.text.from
        s.text.props::{ variant = s.text.variants.isoDate }
        s.text.meta::{ description = Some "ISO 8601 calendar date" }

let testSchema8 =
      s.text.from
        s.text.props::{ variant = s.text.variants.isoTime }
        s.text.meta::{ description = Some "ISO 8601 local time" }

let testSchema9 =
      s.text.from
        s.text.props::{ variant = s.text.variants.isoDuration }
        s.text.meta::{ description = Some "ISO 8601 duration" }

let testSchema10 =
      s.text.from
        s.text.props::{ variant = s.text.variants.uuid }
        s.text.meta::{ description = Some "RFC 4122 UUID" }

let testSchema11 =
      s.text.from
        s.text.props::{ variant = s.text.variants.ipv4 }
        s.text.meta::{ description = Some "IPv4 address" }

let testSchema12 =
      s.text.from
        s.text.props::{ variant = s.text.variants.ipv6 }
        s.text.meta::{ description = Some "IPv6 address" }

let testSchema13 =
      s.text.from
        s.text.props::{ variant = s.text.variants.base64 }
        s.text.meta::{ description = Some "RFC 4648 Base64" }

let testSchema14 =
      s.text.from
        s.text.props::{ variant = s.text.variants.base64url }
        s.text.meta::{ description = Some "RFC 4648 Base64url" }

let testSchema15 =
      s.text.from
        s.text.props::{ variant = s.text.variants.e164 }
        s.text.meta::{ description = Some "E.164 telephone number" }

let schemas =
      [ testSchema1, testSchema2, testSchema3, testSchema4, testSchema5, testSchema6, testSchema7, testSchema8, testSchema9, testSchema10, testSchema11, testSchema12, testSchema13, testSchema14, testSchema15 ]

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
