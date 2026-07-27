let List/map = ../prelude/List/map.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Schema = Grammar.Schema

let liftDefinitions = ../transformer-lift/package.dhall

let renderTypes = ../renderer-typescript/package.dhall

let common = ./common.dhall

let RenderOptions = common.RenderOptions

let TimeMode = common.TimeMode

let renderSchema = ./render-schema.dhall

let renderPrelude = ./render-prelude.dhall

let renderRootSchema =
      \(root : Schema.root.type) ->
      \(options : RenderOptions) ->
        let name = root.meta.name

        let typeName = options.prefix ++ name

        let codec = renderSchema root.contains

        let context = { options, indentation = options.indent }

        let encodeBody = codec.encodeBody context "value" "path"

        let decodeBody = codec.decodeBody context "input" "path" typeName

        let break = options.break

        let indent = options.indent

        in  "function encode${typeName}At(value: ${typeName}, path: string): JsonValue {${break}"
          ++ encodeBody
          ++ "}${break}${break}"
          ++ "function decode${typeName}At(input: unknown, path: string): ${typeName} {${break}"
          ++ decodeBody
          ++ "}${break}${break}"
          ++ "export function encode${typeName}(value: ${typeName}): JsonValue {${break}"
          ++ "${indent}return encode${typeName}At(value, \"$\");${break}"
          ++ "}${break}${break}"
          ++ "export function decode${typeName}(input: unknown): ${typeName} {${break}"
          ++ "${indent}return decode${typeName}At(input, \"$\");${break}"
          ++ "}"

let renderDocument
    : RenderOptions -> Document.Type -> Text
    = \(options : RenderOptions) ->
      \(document : Document.Type) ->
        let document =
              liftDefinitions.transform liftDefinitions.options::{=} document

        let types = renderTypes.render options document

        let rootDefinitions =
              List/map Schema.root.type Text (\(root : Schema.root.type) -> renderRootSchema root options) document.schemas

        in  Text/concatSep "\n\n" [ types, renderPrelude options.time, Text/concatSep "\n\n" rootDefinitions ]

let options =
      { Type = RenderOptions
      , default = { indent = "\t", break = "\n", prefix = "", time = TimeMode.LEGACY }
      }

in  { render = renderDocument, options, time = TimeMode }
