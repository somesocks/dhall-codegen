# `dhall-codegen` Grammar

## About

At a high level, the `dhall-codegen` grammar consists of:

- **Schemas** - A schema is a node in the syntax tree for the grammar, built using a schema constructor (`Schema.<type>.from …`).
- **Roots** - A root is a "base" node for the syntax tree for the grammar, it wraps a schema and assigns it a stable name (`Schema.root.from … Schema.root.meta::{ name = "…" }`).
- **Documents** - A document is a collection of schemas, that can be rendered into a target language.


## Documents

The top-level value consumed by renderers/transformers is the document:

```dhall
Document.Type =
  { headers : List Text
  , schemas : List s.root.type
  , description : Optional Text
  }
```

## Schemas

For brevity, I usually alias `Grammar.Schema` to `s` when defining schemas:

```dhall
let Grammar = ../../dyd/assets/src/grammar.dhall
let Document = Grammar.Document
let s = Grammar.Schema
```

The `s` object contains definition for different types of schemas, each with a consistent interface.

- `s.<type>` — the schema type
- `s.<type>.from` — constructors
- `s.<type>.props` — props type + defaults
- `s.<type>.meta` — meta type + defaults
- `s.<type>.variants` — tagged union variants (when applicable)

Every schema node is created using a consistent pattern:

```dhall
s.<type>.from s.<type>.props::{...} s.<type>.meta::{...}
```

Each "constructor" function expects a props record and a metadata record. Most nodes have reasonable defaults provided for their props/meta, so you can use `::{=}` to fill defaults:

```dhall
s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
```

### Metadata

Today, all schema nodes share the same meta record type:

```dhall
{ description : Optional Text
, sensitive : Bool
}
```

- `description` is used by renderers to provide an inline description of the property (JSDoc, JSON Schema `description`, Zod `.describe()`, etc.).
- `sensitive` is present in the grammar but is not currently consumed by the provided renderers. This is a future extension for future support of languages like Terraform that make a distinction between sensitive and non-sensitive properties.

Root meta extends this with the root a `name`:

```dhall
{ name : Text
, description : Optional Text
, sensitive : Bool
}
```

### Schema types

Below is the complete set of schema node kinds supported by the grammar.

#### Any

Represents an unconstrained value.

Variants:

- `s.any.variants.none` (default)
- `s.any.variants.permissive`

Example:

```dhall
let Unknown =
      s.any.from s.any.props::{=} s.any.meta::{ description = Some "anything" }

let Permissive =
      s.any.from
        s.any.props::{ variant = s.any.variants.permissive }
        s.any.meta::{=}
```

In TypeScript, `none` renders as `unknown`, and `permissive` renders as `any`.

#### Boolean

```dhall
s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
```

#### Number

Variants:

- `none` (default)
- `natural`
- `integer`
- `decimal`

```dhall
let Count =
      s.number.from
        (s.number.props::{ variant = s.number.variants.natural })
        s.number.meta::{ description = Some "Non-negative integer" }
```

#### Text

Variants:

- `none` (default)
- `email`
- `url`
- `literal : Text`

```dhall
let Email =
      s.text.from
        (s.text.props::{ variant = s.text.variants.email })
        s.text.meta::{=}

let Mode =
      s.text.from
        (s.text.props::{ variant = s.text.variants.literal "prod" })
        s.text.meta::{=}
```

#### Time

Represents a timestamp.

```dhall
let CreatedAt =
      s.time.from
        s.time.props::{=}
        s.time.meta::{ description = Some "ISO-8601 date-time" }
```

#### Reference

References a named root definition.

```dhall
let PersonRef =
      s.reference.from
        (s.reference.props::{ to = "Person" })
        s.reference.meta::{=}
```

#### Optional

Wraps a schema to indicate optionality.

```dhall
let MaybeName =
      s.optional.from
        (s.optional.props::{ value = s.text.from s.text.props::{=} s.text.meta::{=} })
        s.optional.meta::{=}
```

Notes:

- In a `record`, optionality is typically expressed by placing the field in `record.props.optional`.
- The **lift transformer** (used by most renderers) will “lift” an `optional` used under a record’s required fields into an optional field where possible.

#### List

```dhall
let Tags =
      s.list.from
        (s.list.props::{ values = s.text.from s.text.props::{=} s.text.meta::{=} })
        s.list.meta::{=}
```

#### Set

Like a list, but with set semantics.

Variants:

- `none` (default)
- `list`

```dhall
let UniqueTags =
      s.set.from
        (s.set.props::{ values = s.text.from s.text.props::{=} s.text.meta::{=}
                      , variant = s.set.variants.none
                      })
        s.set.meta::{=}
```

TypeScript/Python renderers use the variant to pick between `Set<T>` vs `Array<T>`/`List[T]`.

#### Map

Key/value mapping.

Variants:

- `none` (default)
- `record`

```dhall
let Labels =
      s.map.from
        (s.map.props::{
        , keys = s.text.from s.text.props::{=} s.text.meta::{=}
        , values = s.text.from s.text.props::{=} s.text.meta::{=}
        , variant = s.map.variants.record
        })
        s.map.meta::{=}
```

TypeScript renders `none` as `Map<K,V>` and `record` as `Record<K,V>`.

#### OneOf

```dhall
let EmailOrUrl =
      s.oneOf.from
        (s.oneOf.props::{ options =
          [ s.text.from (s.text.props::{ variant = s.text.variants.email }) s.text.meta::{=}
          , s.text.from (s.text.props::{ variant = s.text.variants.url }) s.text.meta::{=}
          ]
        })
        (s.oneOf.meta::{ description = Some "Email or URL" })
```

#### AllOf

Intersection / “must satisfy all”.

```dhall
let AandB =
      s.allOf.from
        (s.allOf.props::{ options = [ SchemaA, SchemaB ] })
        s.allOf.meta::{=}
```

#### Tuple

```dhall
let Pair =
      s.tuple.from
        (s.tuple.props::{ values =
          [ s.text.from s.text.props::{=} s.text.meta::{=}
          , s.number.from (s.number.props::{ variant = s.number.variants.integer }) s.number.meta::{=}
          ]
        })
        s.tuple.meta::{=}
```

#### Record

Records have separate collections for required and optional fields.

The underlying type is a *list of key/value pairs*, so use `toMap` to build it:

```dhall
let Person =
      s.record.from
        (s.record.props::{
        , required = toMap
            { name = s.text.from s.text.props::{=} s.text.meta::{=}
            , id = s.number.from (s.number.props::{ variant = s.number.variants.natural }) s.number.meta::{=}
            }
        , optional = toMap
            { nickname = s.text.from s.text.props::{=} s.text.meta::{=} }
        })
        (s.record.meta::{ description = Some "Person" })
```

#### Function

Represents a function shape.

Variants:

- `none` (default)
- `async`

```dhall
let Fn =
      s.function.from
        (s.function.props::{
        , input = [ s.text.from s.text.props::{=} s.text.meta::{=} ]
        , output = [ s.boolean.from s.boolean.props::{=} s.boolean.meta::{=} ]
        , variant = s.function.variants.async
        })
        (s.function.meta::{ description = Some "Example" })
```

#### Root

Roots give a schema a stable name so it can be referenced and rendered as a top-level definition.

```dhall
let RootPerson =
      s.root.from Person (s.root.meta::{ name = "Person" })
```
