let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let ExpressionFragment
    : Type
    = { encode : RenderContext -> Text -> Text -> Text
      , decode : RenderContext -> Text -> Text -> Text
      }

let RenderFragment
    : Type
    = { encode : RenderContext -> Text -> Text -> Text
      , decode : RenderContext -> Text -> Text -> Text
      , encodeBody : RenderContext -> Text -> Text -> Text
      , decodeBody : RenderContext -> Text -> Text -> Text -> Text
      }

let quote : Text -> Text = \(value : Text) -> Text/show value

let renderSchema
    : s.typeF RenderFragment -> RenderFragment
    = \(layer : s.typeF RenderFragment) ->
        let withBodies
            : ExpressionFragment -> RenderFragment
            = \(fragment : ExpressionFragment) ->
                fragment
              // { encodeBody =
                     \(ctx : RenderContext) ->
                     \(value : Text) ->
                     \(path : Text) ->
                        "${ctx.indentation}return ${fragment.encode ctx value path};"
                 , decodeBody =
                     \(ctx : RenderContext) ->
                     \(value : Text) ->
                     \(path : Text) ->
                     \(typeName : Text) ->
                        "${ctx.indentation}return ${fragment.decode ctx value path} as ${typeName};"
                 }

        let renderRequiredRecordField =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(field : { mapKey : Text, mapValue : RenderFragment }) ->
              \(value : Text) ->
              \(path : Text) ->
                let key = quote field.mapKey

                let fieldPath = "pathField(${path}, ${key})"

                let converted =
                      if    encode
                      then  field.mapValue.encode ctx "object[${key}]" fieldPath
                      else  field.mapValue.decode ctx "object[${key}]" fieldPath

                let break = ctx.options.break

                let indent = ctx.indentation

                in  "${indent}result[${key}] = ${converted};${break}"

        let renderOptionalRecordField =
              \(encode : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(field : { mapKey : Text, mapValue : RenderFragment }) ->
              \(value : Text) ->
              \(path : Text) ->
                let key = quote field.mapKey

                let fieldPath = "pathField(${path}, ${key})"

                let converted =
                      if    encode
                      then  field.mapValue.encode ctx "object[${key}]" fieldPath
                      else  field.mapValue.decode ctx "object[${key}]" fieldPath

                let break = ctx.options.break

                let indent = ctx.indentation

                let condition =
                      if    encode
                      then  "hasOwn(object, ${key}) && object[${key}] !== undefined"
                      else  "hasOwn(object, ${key}) && object[${key}] !== null"

                in  "${indent}if (${condition}) result[${key}] = ${converted};${break}"

        let renderList =
              \(encode : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(child : RenderFragment) ->
                let bodyIndent = ctx.indentation ++ ctx.options.indent

                let loopIndent = bodyIndent ++ ctx.options.indent

                let childContext = ctx // { indentation = loopIndent }

                let converted =
                      if    encode
                      then  child.encode childContext "entries[index]" "pathIndex(path, index)"
                      else  child.decode childContext "entries[index]" "pathIndex(path, index)"

                let resultType = if encode then "JsonValue[]" else "unknown[]"

                let break = ctx.options.break

                in  "((input: unknown, path: string): ${resultType} => {${break}"
                  ++ "${bodyIndent}const entries = asArray(${quote operation}, input, path);${break}"
                  ++ "${bodyIndent}const result: ${resultType} = new Array(entries.length);${break}"
                  ++ "${bodyIndent}for (let index = 0; index < entries.length; index += 1) {${break}"
                  ++ "${loopIndent}result[index] = ${converted};${break}"
                  ++ "${bodyIndent}}${break}"
                  ++ "${bodyIndent}return result;${break}"
                  ++ "${ctx.indentation}})(${value}, ${path})"

        let renderTuple =
              \(encode : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(children : List RenderFragment) ->
                let bodyIndent = ctx.indentation ++ ctx.options.indent

                let childContext = ctx // { indentation = bodyIndent }

                let renderChild =
                      \(index : Natural) ->
                      \(child : RenderFragment) ->
                        let source = "entries[${Natural/show index}]"

                        let itemPath = "pathIndex(path, ${Natural/show index})"

                        in  if    encode
                            then  child.encode childContext source itemPath
                            else  child.decode childContext source itemPath

                let entries = List/mapWithIndex RenderFragment Text renderChild children

                let length = Natural/show (List/length RenderFragment children)

                let resultType = if encode then "JsonValue[]" else "unknown[]"

                let break = ctx.options.break

                in  "((input: unknown, path: string): ${resultType} => {${break}"
                  ++ "${bodyIndent}const entries = asArray(${quote operation}, input, path);${break}"
                  ++ "${bodyIndent}if (entries.length !== ${length}) fail(${quote operation}, path, \"expected tuple of length ${length}\");${break}"
                  ++ "${bodyIndent}return [${Text/concatSep ", " entries}];${break}"
                  ++ "${ctx.indentation}})(${value}, ${path})"

        let renderRecordBody =
              \(encode : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(returnSuffix : Text) ->
              \(required : List { mapKey : Text, mapValue : RenderFragment }) ->
              \(optional : List { mapKey : Text, mapValue : RenderFragment }) ->
                let renderRequired = renderRequiredRecordField encode ctx

                let renderOptional = renderOptionalRecordField encode operation ctx

                let required =
                      List/map
                        { mapKey : Text, mapValue : RenderFragment }
                        Text
                        (\(field : { mapKey : Text, mapValue : RenderFragment }) -> renderRequired field value path)
                        required

                let optional =
                      List/map
                        { mapKey : Text, mapValue : RenderFragment }
                        Text
                        (\(field : { mapKey : Text, mapValue : RenderFragment }) -> renderOptional field value path)
                        optional

                let resultType =
                      if    encode
                      then  "{ [key: string]: JsonValue }"
                      else  "{ [key: string]: unknown }"

                let break = ctx.options.break

                let indent = ctx.indentation

                in  "${indent}const object = asObject(${quote operation}, ${value}, ${path});${break}"
                  ++ "${indent}const result: ${resultType} = {};${break}"
                  ++ Text/concatSep "" (required # optional)
                  ++ "${indent}return result${returnSuffix};${break}"

        let renderRecord =
              \(encode : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(required : List { mapKey : Text, mapValue : RenderFragment }) ->
              \(optional : List { mapKey : Text, mapValue : RenderFragment }) ->
                let bodyContext = ctx // { indentation = ctx.indentation ++ ctx.options.indent }

                let body = renderRecordBody encode operation bodyContext "value" "path" "" required optional

                let resultType =
                      if    encode
                      then  "{ [key: string]: JsonValue }"
                      else  "{ [key: string]: unknown }"

                let break = ctx.options.break

                  in  "((value: unknown, path: string): ${resultType} => {${break}"
                  ++ body
                  ++ "${ctx.indentation}})(${value}, ${path})"

        let renderSet =
              \(encode : Bool) ->
              \(isSet : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(child : RenderFragment) ->
                let bodyIndent = ctx.indentation ++ ctx.options.indent

                let loopIndent = bodyIndent ++ ctx.options.indent

                let childContext = ctx // { indentation = loopIndent }

                let converted =
                      if    encode
                      then  child.encode childContext "entry" "pathIndex(path, index)"
                      else  child.decode childContext "entries[index]" "pathIndex(path, index)"

                let break = ctx.options.break

                in  if    encode
                    then  if    isSet
                          then  "((value: unknown, path: string): JsonValue[] => {${break}"
                        ++ "${bodyIndent}const entries = value instanceof Set ? value : fail(\"encode\", path, \"expected Set\");${break}"
                        ++ "${bodyIndent}const result: JsonValue[] = new Array(entries.size);${break}"
                        ++ "${bodyIndent}let index = 0;${break}"
                        ++ "${bodyIndent}for (const entry of entries) {${break}"
                        ++ "${loopIndent}result[index] = ${converted};${break}"
                        ++ "${loopIndent}index += 1;${break}"
                        ++ "${bodyIndent}}${break}"
                        ++ "${bodyIndent}return result;${break}"
                        ++ "${ctx.indentation}})(${value}, ${path})"
                          else  renderList encode operation ctx value path child
                    else  if    isSet
                          then  "((input: unknown, path: string): Set<unknown> => {${break}"
                              ++ "${bodyIndent}const entries = asArray(\"decode\", input, path);${break}"
                              ++ "${bodyIndent}const result = new Set<unknown>();${break}"
                              ++ "${bodyIndent}for (let index = 0; index < entries.length; index += 1) {${break}"
                              ++ "${loopIndent}result.add(${converted});${break}"
                              ++ "${bodyIndent}}${break}"
                              ++ "${bodyIndent}return result;${break}"
                              ++ "${ctx.indentation}})(${value}, ${path})"
                          else  renderList encode operation ctx value path child

        let renderMap =
              \(encode : Bool) ->
              \(isRecord : Bool) ->
              \(operation : Text) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(keys : RenderFragment) ->
              \(values : RenderFragment) ->
                let bodyIndent = ctx.indentation ++ ctx.options.indent

                let loopIndent = bodyIndent ++ ctx.options.indent

                let childContext = ctx // { indentation = loopIndent }

                let break = ctx.options.break

                in  if    isRecord
                    then  if    encode
                          then  let wireKey = keys.encode childContext "key" "pathField(path, key)"

                          let wireValue = values.encode childContext "object[key]" "pathField(path, key)"

                          in  "((input: unknown, path: string): { [key: string]: JsonValue } => {${break}"
                            ++ "${bodyIndent}const object = asObject(\"encode\", input, path);${break}"
                            ++ "${bodyIndent}const result: { [key: string]: JsonValue } = {};${break}"
                            ++ "${bodyIndent}for (const key in object) {${break}"
                            ++ "${loopIndent}if (!hasOwn(object, key)) continue;${break}"
                            ++ "${loopIndent}const wireKeyValue = ${wireKey};${break}"
                            ++ "${loopIndent}const wireKey = typeof wireKeyValue === \"string\" ? wireKeyValue : fail(\"encode\", pathField(path, key), \"record map keys must encode as strings\");${break}"
                            ++ "${loopIndent}result[wireKey] = ${wireValue};${break}"
                            ++ "${bodyIndent}}${break}"
                            ++ "${bodyIndent}return result;${break}"
                            ++ "${ctx.indentation}})(${value}, ${path})"
                          else  let domainKey = keys.decode childContext "key" "pathField(path, key)"

                                let domainValue = values.decode childContext "object[key]" "pathField(path, key)"

                                in  "((input: unknown, path: string): { [key: string]: unknown } => {${break}"
                                  ++ "${bodyIndent}const object = asObject(\"decode\", input, path);${break}"
                                  ++ "${bodyIndent}const result: { [key: string]: unknown } = {};${break}"
                                  ++ "${bodyIndent}for (const key in object) {${break}"
                                  ++ "${loopIndent}if (!hasOwn(object, key)) continue;${break}"
                                  ++ "${loopIndent}const domainKeyValue = ${domainKey};${break}"
                                  ++ "${loopIndent}const domainKey = typeof domainKeyValue === \"string\" ? domainKeyValue : fail(\"decode\", pathField(path, key), \"record map keys must decode as strings\");${break}"
                                  ++ "${loopIndent}result[domainKey] = ${domainValue};${break}"
                                  ++ "${bodyIndent}}${break}"
                                  ++ "${bodyIndent}return result;${break}"
                                  ++ "${ctx.indentation}})(${value}, ${path})"
                    else  if    encode
                          then  let wireKey = keys.encode childContext "entry[0]" "pathIndex(path, index)"

                                        let wireValue = values.encode childContext "entry[1]" "pathIndex(path, index)"

                                        in  "((value: unknown, path: string): JsonValue[] => {${break}"
                                         ++ "${bodyIndent}const entries = value instanceof Map ? value : fail(\"encode\", path, \"expected Map\");${break}"
                                         ++ "${bodyIndent}const result: JsonValue[] = new Array(entries.size);${break}"
                                         ++ "${bodyIndent}let index = 0;${break}"
                                         ++ "${bodyIndent}for (const entry of entries) {${break}"
                                        ++ "${loopIndent}result[index] = { key: ${wireKey}, value: ${wireValue} };${break}"
                                        ++ "${loopIndent}index += 1;${break}"
                                        ++ "${bodyIndent}}${break}"
                                        ++ "${bodyIndent}return result;${break}"
                                        ++ "${ctx.indentation}})(${value}, ${path})"
                          else  let domainKey = keys.decode childContext "entry[\"key\"]" "pathField(pathIndex(path, index), \"key\")"

                                       let domainValue = values.decode childContext "entry[\"value\"]" "pathField(pathIndex(path, index), \"value\")"

                                       in  "((input: unknown, path: string): Map<unknown, unknown> => {${break}"
                                        ++ "${bodyIndent}const entries = asArray(\"decode\", input, path);${break}"
                                        ++ "${bodyIndent}const result = new Map<unknown, unknown>();${break}"
                                        ++ "${bodyIndent}for (let index = 0; index < entries.length; index += 1) {${break}"
                                        ++ "${loopIndent}const entry = asObject(\"decode\", entries[index], pathIndex(path, index));${break}"
                                        ++ "${loopIndent}if (!hasOwn(entry, \"key\") || !hasOwn(entry, \"value\")) fail(\"decode\", pathIndex(path, index), \"expected map entry\");${break}"
                                        ++ "${loopIndent}result.set(${domainKey}, ${domainValue});${break}"
                                        ++ "${bodyIndent}}${break}"
                                        ++ "${bodyIndent}return result;${break}"
                                        ++ "${ctx.indentation}})(${value}, ${path})"

        let renderOneOf =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(path : Text) ->
              \(options : List RenderFragment) ->
                let bodyIndent = ctx.indentation ++ ctx.options.indent

                let tryIndent = bodyIndent ++ ctx.options.indent

                let branchContext = ctx // { indentation = tryIndent }

                let renderOption =
                      \(option : RenderFragment) ->
                        let converted =
                              if    encode
                              then  option.encode branchContext "value" "path"
                              else  option.decode branchContext "value" "path"

                        in  "${bodyIndent}try {${ctx.options.break}"
                          ++ "${tryIndent}return ${converted};${ctx.options.break}"
                          ++ "${bodyIndent}} catch (error) {${ctx.options.break}"
                          ++ "${tryIndent}if (!(error instanceof CodecError)) throw error;${ctx.options.break}"
                          ++ "${bodyIndent}}${ctx.options.break}"

                let attempts = List/map RenderFragment Text renderOption options

                let operation = if encode then "encode" else "decode"

                let resultType = if encode then "JsonValue" else "unknown"

                in  "((value: unknown, path: string): ${resultType} => {${ctx.options.break}"
                  ++ Text/concatSep "" attempts
                  ++ "${bodyIndent}return fail(${quote operation}, path, \"no OneOf option matched\");${ctx.options.break}"
                  ++ "${ctx.indentation}})(${value}, ${path})"

        let renderer =
              merge
                { Any =
                    \(_ : s.any.node.Type) ->
                      withBodies { encode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "encodeAny(${value}, ${path})"
                      , decode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "decodeAny(${value}, ${path})"
                      }
                , Boolean =
                    \(_ : s.boolean.node.Type) ->
                      withBodies { encode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "encodeBoolean(${value}, ${path})"
                      , decode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "decodeBoolean(${value}, ${path})"
                      }
                , Number =
                    \(node : s.number.node.Type) ->
                      let variant =
                            merge
                              { none = "none"
                              , natural = "natural"
                              , integer = "integer"
                              , decimal = "decimal"
                              }
                              node.props.variant

                      in  withBodies { encode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "encodeNumber(${quote variant}, ${value}, ${path})"
                          , decode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "decodeNumber(${quote variant}, ${value}, ${path})"
                          }
                , Text =
                    \(node : s.text.node.Type) ->
                      let variant =
                            merge
                              { none = "none"
                              , email = "email"
                              , url = "url"
                              , base64 = "base64"
                              , base64url = "base64url"
                              , e164 = "e164"
                              , ipv4 = "ipv4"
                              , ipv6 = "ipv6"
                              , isoDate = "isoDate"
                              , isoDateTime = "isoDateTime"
                              , isoDuration = "isoDuration"
                              , isoTime = "isoTime"
                              , uuid = "uuid"
                              , literal = \(value : Text) -> "literal:${value}"
                              }
                              node.props.variant

                      in  withBodies { encode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "encodeText(${quote variant}, ${value}, ${path})"
                          , decode = \(_ : RenderContext) -> \(value : Text) -> \(path : Text) -> "decodeText(${quote variant}, ${value}, ${path})"
                          }
                , Time =
                    \(node : s.time.node.Type) ->
                      let variant =
                            merge
                              { none = "none"
                              , date = "date"
                              , time = "time"
                              , duration = "duration"
                              }
                              node.props.variant

                      in  withBodies { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(path : Text) ->
                                "encodeTime(${quote variant}, ${value}, ${path})"
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(path : Text) ->
                                "decodeTime(${quote variant}, ${value}, ${path})"
                          }
                , Reference =
                    \(node : s.reference.node.Type) ->
                      withBodies { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(path : Text) ->
                            "encode${ctx.options.prefix}${node.props.to}At(${value} as ${ctx.options.prefix}${node.props.to}, ${path})"
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(path : Text) ->
                            "decode${ctx.options.prefix}${node.props.to}At(${value}, ${path})"
                      }
                , Optional =
                    \(node : (s.optional.nodeF RenderFragment).Type) ->
                      withBodies { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(path : Text) ->
                            "${value} === undefined || ${value} === null ? null : ${node.props.value.encode ctx value path}"
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(path : Text) ->
                            "${value} === null ? undefined : ${node.props.value.decode ctx value path}"
                      }
                , List =
                    \(node : (s.list.nodeF RenderFragment).Type) ->
                      withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderList True "encode" ctx value path node.props.values
                      , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderList False "decode" ctx value path node.props.values
                      }
                , Set =
                    \(node : (s.set.nodeF RenderFragment).Type) ->
                      let isSet = merge { none = True, list = False } node.props.variant

                      in  withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderSet True isSet "encode" ctx value path node.props.values
                          , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderSet False isSet "decode" ctx value path node.props.values
                          }
                , Map =
                    \(node : (s.map.nodeF RenderFragment).Type) ->
                      let isRecord = merge { none = False, record = True } node.props.variant

                      in  withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderMap True isRecord "encode" ctx value path node.props.keys node.props.values
                          , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderMap False isRecord "decode" ctx value path node.props.keys node.props.values
                          }
                , OneOf =
                    \(node : (s.oneOf.nodeF RenderFragment).Type) ->
                      withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderOneOf True ctx value path node.props.options
                      , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderOneOf False ctx value path node.props.options
                      }
                , AllOf =
                    \(_ : (s.allOf.nodeF RenderFragment).Type) ->
                      withBodies { encode = \(_ : RenderContext) -> \(_ : Text) -> \(path : Text) -> "unsupported(\"encode\", ${path}, \"AllOf\")"
                      , decode = \(_ : RenderContext) -> \(_ : Text) -> \(path : Text) -> "unsupported(\"decode\", ${path}, \"AllOf\")"
                      }
                , Tuple =
                    \(node : (s.tuple.nodeF RenderFragment).Type) ->
                      withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderTuple True "encode" ctx value path node.props.values
                      , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderTuple False "decode" ctx value path node.props.values
                      }
                , Record =
                    \(node : (s.record.nodeF RenderFragment).Type) ->
                      let fragment =
                            withBodies { encode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderRecord True "encode" ctx value path node.props.required node.props.optional
                      , decode = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderRecord False "decode" ctx value path node.props.required node.props.optional
                      }

                      in  fragment
                        // { encodeBody = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> renderRecordBody True "encode" ctx value path "" node.props.required node.props.optional
                           , decodeBody = \(ctx : RenderContext) -> \(value : Text) -> \(path : Text) -> \(typeName : Text) -> renderRecordBody False "decode" ctx value path " as ${typeName}" node.props.required node.props.optional
                           }
                , Function =
                    \(_ : (s.function.nodeF RenderFragment).Type) ->
                      withBodies { encode = \(_ : RenderContext) -> \(_ : Text) -> \(path : Text) -> "unsupported(\"encode\", ${path}, \"Function\")"
                      , decode = \(_ : RenderContext) -> \(_ : Text) -> \(path : Text) -> "unsupported(\"decode\", ${path}, \"Function\")"
                      }
                }
                layer

        in  renderer

let renderSchema = s.fold s.typeF RenderFragment renderSchema

in  renderSchema
