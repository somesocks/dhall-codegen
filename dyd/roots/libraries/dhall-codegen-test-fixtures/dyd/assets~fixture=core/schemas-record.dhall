let List/mapWithIndex = ./dhall-codegen/prelude/List/mapWithIndex.dhall

let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 =
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

let testSchema2 =
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
        s.record.meta::{ description = Some "a record" }

let testSchema3 =
      s.record.from
        s.record.props::{
        , required = toMap
            { name = s.text.from s.text.props::{=} s.text.meta::{=}
            , age =
                s.number.from
                  s.number.props::{ variant = s.number.variants.natural }
                  s.number.meta::{=}
            , deceased = s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
            , contact =
                s.record.from
                  s.record.props::{
                  , required = toMap
                      { email =
                          s.optional.from
                            s.optional.props::{
                            , value =
                                s.text.from s.text.props::{=} s.text.meta::{=}
                            }
                            s.optional.meta::{=}
                      , phone =
                          s.optional.from
                            s.optional.props::{
                            , value =
                                s.text.from s.text.props::{=} s.text.meta::{=}
                            }
                            s.optional.meta::{=}
                      }
                  }
                  s.record.meta::{=}
            }
        }
        s.record.meta::{ description = Some "a record with an embedded record" }

let testSchema4 =
      s.record.from
        s.record.props::{
        , required = toMap
            { name = s.text.from s.text.props::{=} s.text.meta::{=} }
        , optional = toMap
            { age =
                s.number.from
                  s.number.props::{ variant = s.number.variants.natural }
                  s.number.meta::{=}
            , deceased = s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
            }
        }
        s.record.meta::{ description = Some "a record with optional props" }

let testSchema5 =
      s.record.from
        s.record.props::{
        , required = toMap
            { id = s.text.from s.text.props::{=} s.text.meta::{=}
            , status = s.text.from s.text.props::{=} s.text.meta::{=}
            }
        , optional = toMap
            { age =
                s.number.from
                  s.number.props::{ variant = s.number.variants.natural }
                  s.number.meta::{=}
            }
        , variant = s.record.variants.interface
        }
        s.record.meta::{=}

let schemas = [ testSchema1, testSchema2, testSchema3, testSchema4, testSchema5 ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "RecordTest${Natural/show index}"
          , description = Some "record test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
