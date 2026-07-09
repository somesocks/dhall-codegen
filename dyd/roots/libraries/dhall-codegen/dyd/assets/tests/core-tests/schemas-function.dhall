let List/mapWithIndex = ../../src/prelude/List/mapWithIndex.dhall

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let Grammar = ../../src/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let testSchema1 = s.function.from s.function.props::{=} s.function.meta::{=}

let testSchema2 =
      s.function.from
        s.function.props::{ variant = s.function.variants.async }
        s.function.meta::{=}

let testSchema3 =
      s.function.from
        s.function.props::{
        , input = [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=} ]
        }
        s.function.meta::{=}

let testSchema4 =
      s.function.from
        s.function.props::{
        , input = [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=} ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema5 =
      s.function.from
        s.function.props::{
        , input =
          [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          , s.number.from s.number.props::{=} s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        }
        s.function.meta::{=}

let testSchema6 =
      s.function.from
        s.function.props::{
        , input =
          [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          , s.number.from s.number.props::{=} s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema7 = s.function.from s.function.props::{=} s.function.meta::{=}

let testSchema8 =
      s.function.from
        s.function.props::{ variant = s.function.variants.async }
        s.function.meta::{=}

let testSchema9 =
      s.function.from
        s.function.props::{
        , output = [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=} ]
        }
        s.function.meta::{=}

let testSchema10 =
      s.function.from
        s.function.props::{
        , output = [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=} ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema11 =
      s.function.from
        s.function.props::{
        , output =
          [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          , s.number.from s.number.props::{=} s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        }
        s.function.meta::{=}

let testSchema12 =
      s.function.from
        s.function.props::{
        , output =
          [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          , s.number.from s.number.props::{=} s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema13 =
      s.function.from
        s.function.props::{
        , input =
          [ s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        , output =
          [ s.text.from s.text.props::{=} s.text.meta::{=}
          , s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          ]
        }
        s.function.meta::{=}

let testSchema14 =
      s.function.from
        s.function.props::{
        , input =
          [ s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{=}
          , s.text.from s.text.props::{=} s.text.meta::{=}
          ]
        , output =
          [ s.text.from s.text.props::{=} s.text.meta::{=}
          , s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
          ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema15 =
      s.function.from
        s.function.props::{
        , input =
          [ s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          ]
        , output =
          [ s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let testSchema16 =
      s.function.from
        s.function.props::{
        , input =
          [ s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          , s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          ]
        , output =
          [ s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          , s.record.from
              s.record.props::{
              , required = toMap
                  { foo =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.natural }
                        s.number.meta::{=}
                  , bar = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
              }
              s.record.meta::{=}
          ]
        , variant = s.function.variants.async
        }
        s.function.meta::{=}

let schemas =
      [ testSchema1
      , testSchema2
      , testSchema3
      , testSchema4
      , testSchema5
      , testSchema6
      , testSchema7
      , testSchema8
      , testSchema9
      , testSchema10
      , testSchema11
      , testSchema12
      , testSchema13
      , testSchema14
      , testSchema15
      , testSchema16
      ]

let mapSchema =
      \(index : Natural) ->
      \(schema : s.type) ->
        s.root.from
          schema
          s.root.meta::{
          , name = "FunctionTest${Natural/show index}"
          , description = Some "function test ${Natural/show index}"
          }

let schemas = List/mapWithIndex s.type s.root.type mapSchema schemas

in  schemas
