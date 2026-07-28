# Codecs

## About

Codecs are renderers that generate both type/model definitions from schemas and helper functions to encode/decode the data models to/from a serialized format.

## TypeScript - JSON

**Path:** `dhall-codegen/codec-typescript-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-typescript-json/package.dhall

in  Codec.render Codec.options::{=} myDocument
```

Given a root schema named `Person`, the codec generates:

```ts
export function encodePerson(value: Person): JsonValue;
export function decodePerson(input: unknown): Person;
```

Both functions throw `CodecError` when validation fails. The error identifies the failed operation (`encode` or `decode`) and the JSON path.

The TypeScript codec renderer uses the same options as the TypeScript renderer:

```dhall
Codec.options.Type =
  { indent : Text
  , break : Text
  , prefix : Text
  , time : < LEGACY | TEMPORAL >
  }
```

`time = Codec.time.TEMPORAL` generates code that uses `Temporal`. If the target environment does not provide `Temporal`, a polyfill import can be supplied through the document headers.

## Go - JSON

**Path:** `dhall-codegen/codec-golang-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-golang-json/package.dhall

in  Codec.render Codec.options::{ package = Some "models" } myDocument
```

Given a root schema named `Person`, the codec generates:

```go
func EncodePerson(value Person) (error, any)
func DecodePerson(input any) (error, Person)
```

The JSON-value boundary uses standard Go values: `map[string]any`, `[]any`, strings, booleans, `nil`, `float64`, and `json.Number`. Encoded numeric values are `json.Number` to preserve integer precision.

Go represents union types (`oneOf` schemas) as tagged union structs:

```dhall
let TextOrNatural =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.text.from
              s.text.props::{=}
              s.text.meta::{ name = Some "Text" }
          , s.number.from
              s.number.props::{ variant = s.number.variants.natural }
              s.number.meta::{ name = Some "Natural" }
          ]
        }
        s.oneOf.meta::{=}

let RootTextOrNatural =
      s.root.from TextOrNatural (s.root.meta::{ name = "TextOrNatural" })
```

```go
type TextOrNaturalKind string

const (
	TextOrNaturalKindText TextOrNaturalKind = "Text"
	TextOrNaturalKindNatural TextOrNaturalKind = "Natural"
)

type TextOrNatural struct {
	Kind    TextOrNaturalKind `json:"kind"`
	Text    *string           `json:"Text,omitempty"`
	Natural *int              `json:"Natural,omitempty"`
}
```

Tagged union structs are synthetic Go representations. The codec does not emit them in encoded JSON or expect them while decoding JSON. For encoding, `Kind` selects the option field to encode. For decoding, the codec tries options in declaration order and selects the first that matches the JSON value.

For interface-record schemas, the codec emits a private concrete implementation of the generated Go interface. Decoding returns that implementation; encoding accepts any value that implements the generated interface methods.

## Python 3.11 - JSON

**Path:** `dhall-codegen/codec-python-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-python-json/package.dhall

in  Codec.render myDocument
```

Given a root schema named `Person`, the codec generates:

```python
def encode_Person(value: Person) -> Any: ...
def decode_Person(input: Any) -> Person: ...
```

Invalid input raises `CodecError`, a `ValueError` carrying the operation and JSON path. The JSON-value boundary is Python's standard JSON tree: `None`, `bool`, `int | float`, `str`, `list`, and string-keyed `dict` values.

The codec validates fields directly, then uses Pydantic `model_construct` to build generated `BaseModel` records without applying a second coercing validation pass. Protocol-record decoding returns a generated private `BaseModel` implementation; encoding accepts any object with the protocol's declared attributes.

Python's generated `set[set[T]]` and `dict[BaseModel, BaseModel]` shapes are not currently instantiable because nested mutable sets and Pydantic models are unhashable. This is a Python type-renderer limitation that needs a separate representation design.
