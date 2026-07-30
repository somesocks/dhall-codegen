let Grammar = ./dhall-codegen/grammar.dhall

let s = Grammar.Schema

let TextValue =
      s.record.from
        s.record.props::{
        , required =
            toMap
              { type =
                  s.text.from
                    s.text.props::{ variant = s.text.variants.literal "text" }
                    s.text.meta::{=}
              , content = s.text.from s.text.props::{=} s.text.meta::{=}
              }
        , optional = [] : List { mapKey : Text, mapValue : s.type }
        }
        s.record.meta::{ name = Some "TextValue" }

let EmptyValue =
      s.record.from
        s.record.props::{
        , required =
            toMap
              { type =
                  s.text.from
                    s.text.props::{ variant = s.text.variants.literal "empty" }
                    s.text.meta::{=}
              }
        , optional = [] : List { mapKey : Text, mapValue : s.type }
        }
        s.record.meta::{ name = Some "EmptyValue" }

let Value =
      s.oneOf.from
        s.oneOf.props::{ options = [ TextValue, EmptyValue ] }
        s.oneOf.meta::{=}

let OptionalNestedOneOf =
      s.record.from
        s.record.props::{
        , required = toMap { name = s.text.from s.text.props::{=} s.text.meta::{=} }
        , optional = toMap { value = Value }
        }
        s.record.meta::{=}

in  [ s.root.from OptionalNestedOneOf s.root.meta::{ name = "OptionalNestedOneOf" } ]
