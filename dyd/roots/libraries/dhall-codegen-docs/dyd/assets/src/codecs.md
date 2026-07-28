# JSON Codecs

## About

JSON codecs generate type-directed conversion functions between generated domain values and standard JSON-value trees. They validate values while encoding and decoding; they do not serialize JSON text themselves.

All codecs use the lifted document, so nested records are emitted as named definitions. They generate static conversion code and do not embed runtime schema descriptors.

## Shared Semantics

- `OneOf` uses ordered first-match behavior for both encoding and decoding. The first option that validates successfully wins.
- Record decoding requires declared required fields and ignores undeclared JSON object fields. This makes overlapping records deterministic: option order controls whether an earlier, less-specific record consumes extra fields.
- `Any` validates a JSON tree without copying it.
- `AllOf` and `Function` currently raise or return an unsupported-codec error.
- Codec fixture and snapshot coverage currently includes the core and Person documents. Recursive and Stripe fixture variants are not yet enabled for codecs.

## TypeScript

**Path:** `dhall-codegen/codec-typescript-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-typescript-json/package.dhall

in  Codec.render Codec.options::{=} myDocument
```

For every root `Person`, output exports:

```ts
export function encodePerson(value: Person): JsonValue;
export function decodePerson(input: unknown): Person;
```

Invalid input throws `CodecError`, which includes an `encode` or `decode` operation and a JSON path. `JsonValue` is the generated recursive JSON union.

The options match the TypeScript renderer:

```dhall
Codec.options.Type =
  { indent : Text
  , break : Text
  , prefix : Text
  , time : < LEGACY | TEMPORAL >
  }
```

`time = Codec.time.TEMPORAL` requires a `Temporal` binding supplied through `Document.headers`, for example `import { Temporal } from "@js-temporal/polyfill";`.

## Go

**Path:** `dhall-codegen/codec-golang-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-golang-json/package.dhall

in  Codec.render Codec.options::{ package = Some "models" } myDocument
```

For every root `Person`, output exports error-first functions:

```go
func EncodePerson(value Person) (error, any)
func DecodePerson(input any) (error, Person)
```

The JSON-value boundary uses standard Go values: `map[string]any`, `[]any`, strings, booleans, `nil`, `float64`, and `json.Number`. Encoded numeric values are `json.Number` to preserve integer precision.

Go `OneOf` domain types are generated tagged wrappers. Encoding checks populated option fields in declaration order and emits the first matching field's JSON value; the wrapper `Kind` is never encoded. Decoding tries JSON options in declaration order, populates the selected field, and sets `Kind` as domain metadata.

For interface-record schemas, the codec emits a private concrete implementation of the generated Go interface. Decoding returns that implementation; encoding accepts any value that implements the generated interface methods.

## Python 3.11

**Path:** `dhall-codegen/codec-python-json/package.dhall`

```dhall
let Codec = ./dhall-codegen/codec-python-json/package.dhall

in  Codec.render myDocument
```

For every root `Person`, output exports:

```python
def encode_Person(value: Person) -> Any: ...
def decode_Person(input: Any) -> Person: ...
```

Invalid input raises `CodecError`, a `ValueError` carrying the operation and JSON path. The JSON-value boundary is Python's standard JSON tree: `None`, `bool`, `int | float`, `str`, `list`, and string-keyed `dict` values.

The codec validates fields directly, then uses Pydantic `model_construct` to build generated `BaseModel` records without applying a second coercing validation pass. Protocol-record decoding returns a generated private `BaseModel` implementation; encoding accepts any object with the protocol's declared attributes.

Python's generated `set[set[T]]` and `dict[BaseModel, BaseModel]` shapes are not currently instantiable because nested mutable sets and Pydantic models are unhashable. This is a Python type-renderer limitation that needs a separate representation design.
