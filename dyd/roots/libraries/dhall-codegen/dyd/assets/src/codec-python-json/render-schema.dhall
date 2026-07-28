let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Bool/not = ../prelude/Bool/not.dhall

let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let Fragment = common.Fragment

let RecordNode = (s.record.nodeF Fragment).Type

let renderInterfaceImplementation =
      \(node : RecordNode) ->
      \(name : Text) ->
        let field =
              \(optional : Bool) ->
              \(entry : { mapKey : Text, mapValue : Fragment }) ->
                let typ = entry.mapValue.pythonType ({ indent = "", label = "" })

                in  "    ${entry.mapKey}: ${typ}${if optional then " | None = None" else ""}\n"

        in  merge
              { none = ""
              , interface =
                  "class _${name}(BaseModel):\n"
                  ++ Text/concat (List/map { mapKey : Text, mapValue : Fragment } Text (field False) node.props.required)
                  ++ Text/concat (List/map { mapKey : Text, mapValue : Fragment } Text (field True) node.props.optional)
              }
              node.props.variant

let renderRootDecode =
      \(node : RecordNode) ->
      \(name : Text) ->
        merge
          { none = "return ${name}.model_construct(**result)\n"
          , interface = "return _${name}.model_construct(**result)\n"
          }
          node.props.variant

let quote : Text -> Text = \(value : Text) -> Text/show value

let child = \(ctx : RenderContext) -> ctx // { label = ctx.label ++ "x" }

let renderSchema : s.typeF Fragment -> Fragment =
      \(layer : s.typeF Fragment) ->
        let recordFields =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
                let renderRequired =
                      \(index : Natural) ->
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        let key = quote field.mapKey

                        let fieldPath = "_field(${path}, ${key})"

                        in  if    encode
                            then  "${ctx.indent}${target}[${key}] = None\n"
                              ++ field.mapValue.encode (child ctx) "${value}.${field.mapKey}" "${target}[${key}]" fieldPath
                            else  "${ctx.indent}if ${key} not in object:\n${ctx.indent}    _fail(\"decode\", ${fieldPath}, \"missing required field\")\n"
                              ++ field.mapValue.decode (child ctx) "object[${key}]" "${target}[${key}]" fieldPath

                let renderOptional =
                      \(index : Natural) ->
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        let key = quote field.mapKey

                        let fieldPath = "_field(${path}, ${key})"

                        in  if    encode
                            then  "${ctx.indent}if ${value}.${field.mapKey} is not None:\n"
                              ++ field.mapValue.encode (ctx // { indent = ctx.indent ++ "    " }) "${value}.${field.mapKey}" "${target}[${key}]" fieldPath
                            else  "${ctx.indent}if ${key} in object:\n"
                              ++ field.mapValue.decode (ctx // { indent = ctx.indent ++ "    " }) "object[${key}]" "${target}[${key}]" fieldPath
                              ++ "${ctx.indent}else:\n${ctx.indent}    ${target}[${key}] = None\n"

                in  Text/concat
                      ( List/mapWithIndex { mapKey : Text, mapValue : Fragment } Text renderRequired required
                      # List/mapWithIndex { mapKey : Text, mapValue : Fragment } Text renderOptional optional
                      )

        let renderRecord =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
                if    encode
                then  "${ctx.indent}${target} = {}\n"
                  ++ recordFields True ctx value target path required optional
                else  "${ctx.indent}object = _object(\"decode\", ${value}, ${path})\n${ctx.indent}${target} = {}\n"
                  ++ recordFields False ctx value target path required optional

        let renderList =
              \(encode : Bool) ->
              \(isSet : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(item : Fragment) ->
                let source = if encode then value else "_array(\"decode\", ${value}, ${path})"

                let prefix =
                      if    encode
                      then  if isSet
                            then  "${ctx.indent}if not isinstance(${value}, set):\n${ctx.indent}    _fail(\"encode\", ${path}, \"expected set\")\n"
                            else  "${ctx.indent}if not isinstance(${value}, list):\n${ctx.indent}    _fail(\"encode\", ${path}, \"expected list\")\n"
                      else  ""

                let result = if isSet && Bool/not encode then "set()" else "[]"

                let converted = "converted_${ctx.label}"

                let append = if isSet && Bool/not encode then "${target}.add(${converted})" else "${target}.append(${converted})"

                let convert = if encode then item.encode else item.decode

                in  prefix
                  ++ "${ctx.indent}${target} = ${result}\n${ctx.indent}for index, entry in enumerate(${source}):\n"
                  ++ convert (ctx // { indent = ctx.indent ++ "    ", label = ctx.label ++ "l" }) "entry" converted "_index(${path}, index)"
                  ++ "${ctx.indent}    ${append}\n"

        let renderTuple =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(values : List Fragment) ->
                let source = if encode then value else "_array(\"decode\", ${value}, ${path})"

                let length = Natural/show (List/length Fragment values)

                let convert = if encode then (\(item : Fragment) -> item.encode) else (\(item : Fragment) -> item.decode)

                let entry =
                      \(index : Natural) ->
                      \(item : Fragment) ->
                        convert item ctx "entries[${Natural/show index}]" "${target}[${Natural/show index}]" "_index(${path}, ${Natural/show index})"

                let footer = if encode then "" else "${ctx.indent}${target} = tuple(${target})\n"

                in  "${ctx.indent}entries = ${source}\n${ctx.indent}if not isinstance(entries, (list, tuple)) or len(entries) != ${length}:\n${ctx.indent}    _fail(\"${if encode then "encode" else "decode"}\", ${path}, \"expected tuple of length ${length}\")\n${ctx.indent}${target} = [None] * ${length}\n"
                  ++ Text/concat (List/mapWithIndex Fragment Text entry values)
                  ++ footer

        let renderMap =
              \(encode : Bool) ->
              \(record : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(keys : Fragment) ->
              \(values : Fragment) ->
                let wireKey = "wire_key_${ctx.label}"

                let wireValue = "wire_value_${ctx.label}"

                let domainKey = "domain_key_${ctx.label}"

                let domainValue = "domain_value_${ctx.label}"

                let keyContext = ctx // { indent = ctx.indent ++ "    ", label = ctx.label ++ "k" }

                let valueContext = ctx // { indent = ctx.indent ++ "    ", label = ctx.label ++ "v" }

                in  if    record
                then  if    encode
                      then  "${ctx.indent}if not isinstance(${value}, dict):\n${ctx.indent}    _fail(\"encode\", ${path}, \"expected dict\")\n${ctx.indent}${target} = {}\n${ctx.indent}for key, entry in ${value}.items():\n"
                        ++ keys.encode keyContext "key" wireKey "_field(${path}, str(key))"
                        ++ "${ctx.indent}    if not isinstance(${wireKey}, str):\n${ctx.indent}        _fail(\"encode\", ${path}, \"record map keys must encode as strings\")\n"
                        ++ values.encode valueContext "entry" wireValue "_field(${path}, ${wireKey})"
                        ++ "${ctx.indent}    ${target}[${wireKey}] = ${wireValue}\n"
                      else  "${ctx.indent}object = _object(\"decode\", ${value}, ${path})\n${ctx.indent}${target} = {}\n${ctx.indent}for key, entry in object.items():\n"
                        ++ keys.decode keyContext "key" domainKey "_field(${path}, key)"
                        ++ "${ctx.indent}    if not isinstance(${domainKey}, str):\n${ctx.indent}        _fail(\"decode\", ${path}, \"record map keys must decode as strings\")\n"
                        ++ values.decode valueContext "entry" domainValue "_field(${path}, key)"
                        ++ "${ctx.indent}    ${target}[${domainKey}] = ${domainValue}\n"
                else  if    encode
                      then  "${ctx.indent}if not isinstance(${value}, dict):\n${ctx.indent}    _fail(\"encode\", ${path}, \"expected dict\")\n${ctx.indent}${target} = []\n${ctx.indent}for key, entry in ${value}.items():\n"
                        ++ keys.encode keyContext "key" wireKey "_index(${path}, len(${target}))"
                        ++ values.encode valueContext "entry" wireValue "_index(${path}, len(${target}))"
                        ++ "${ctx.indent}    ${target}.append({\"key\": ${wireKey}, \"value\": ${wireValue}})\n"
                      else  "${ctx.indent}entries = _array(\"decode\", ${value}, ${path})\n${ctx.indent}${target} = {}\n${ctx.indent}for index, entry in enumerate(entries):\n${ctx.indent}    item = _object(\"decode\", entry, _index(${path}, index))\n${ctx.indent}    if \"key\" not in item or \"value\" not in item:\n${ctx.indent}        _fail(\"decode\", _index(${path}, index), \"expected map entry\")\n"
                        ++ keys.decode keyContext "item[\"key\"]" domainKey "_field(_index(${path}, index), \"key\")"
                        ++ values.decode valueContext "item[\"value\"]" domainValue "_field(_index(${path}, index), \"value\")"
                        ++ "${ctx.indent}    ${target}[${domainKey}] = ${domainValue}\n"

        let renderOneOf =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(options : List Fragment) ->
                let convert = if encode then (\(option : Fragment) -> option.encode) else (\(option : Fragment) -> option.decode)

                let branch =
                        \(index : Natural) ->
                        \(option : Fragment) ->
                        "${ctx.indent}if not matched:\n${ctx.indent}    try:\n"
                        ++ convert option (ctx // { indent = ctx.indent ++ "        " }) value target path
                        ++ "${ctx.indent}        matched = True\n${ctx.indent}    except CodecError:\n${ctx.indent}        pass\n"

                in  "${ctx.indent}matched = False\n"
                  ++ Text/concat (List/mapWithIndex Fragment Text branch options)
                  ++ "${ctx.indent}if not matched:\n${ctx.indent}    _fail(\"${if encode then "encode" else "decode"}\", ${path}, \"no OneOf option matched\")\n"

        let renderer =
              merge
                { Any = \(_ : s.any.node.Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _any(\"encode\", ${value}, ${path})\n"
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _any(\"decode\", ${value}, ${path})\n"
                    , pythonType = \(_ : RenderContext) -> "Any"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , Boolean = \(_ : s.boolean.node.Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}if not isinstance(${value}, bool):\n${ctx.indent}    _fail(\"encode\", ${path}, \"expected boolean\")\n${ctx.indent}${target} = ${value}\n"
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}if not isinstance(${value}, bool):\n${ctx.indent}    _fail(\"decode\", ${path}, \"expected boolean\")\n${ctx.indent}${target} = ${value}\n"
                    , pythonType = \(_ : RenderContext) -> "bool"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , Number = \(node : s.number.node.Type) ->
                    let variant = merge { none = "none", natural = "natural", integer = "integer", decimal = "decimal" } node.props.variant

                    let integer = merge { none = False, natural = True, integer = True, decimal = False } node.props.variant

                    in  { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _number(\"encode\", ${value}, ${path}, ${quote variant})\n"
                        , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _number(\"decode\", ${value}, ${path}, ${quote variant})\n"
                        , pythonType = \(_ : RenderContext) -> if integer then "int" else "float"
                        , interfaceImplementation = \(_ : Text) -> ""
                        , rootDecode = \(_ : Text) -> "return result\n"
                        }
                , Text = \(node : s.text.node.Type) ->
                    let variant = merge { none = "none", email = "email", url = "url", base64 = "base64", base64url = "base64url", e164 = "e164", ipv4 = "ipv4", ipv6 = "ipv6", isoDate = "isoDate", isoDateTime = "isoDateTime", isoDuration = "isoDuration", isoTime = "isoTime", uuid = "uuid", literal = \(text : Text) -> "literal:${text}" } node.props.variant
                    in  { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _text(\"encode\", ${value}, ${path}, ${quote variant})\n"
                        , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _text(\"decode\", ${value}, ${path}, ${quote variant})\n"
                        , pythonType = \(_ : RenderContext) -> "str"
                        , interfaceImplementation = \(_ : Text) -> ""
                        , rootDecode = \(_ : Text) -> "return result\n"
                        }
                , Time = \(node : s.time.node.Type) ->
                    let variant = merge { none = "none", date = "date", time = "time", duration = "duration" } node.props.variant
                    in  { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _time(\"encode\", ${value}, ${path}, ${quote variant})\n"
                        , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _time(\"decode\", ${value}, ${path}, ${quote variant})\n"
                        , pythonType = \(_ : RenderContext) -> merge { none = "datetime", date = "date", time = "time", duration = "str" } node.props.variant
                        , interfaceImplementation = \(_ : Text) -> ""
                        , rootDecode = \(_ : Text) -> "return result\n"
                        }
                , Reference = \(node : s.reference.node.Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _encode_${node.props.to}_at(${value}, ${path})\n"
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}${target} = _decode_${node.props.to}_at(${value}, ${path})\n"
                    , pythonType = \(_ : RenderContext) -> node.props.to
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , Optional = \(node : (s.optional.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}if ${value} is None:\n${ctx.indent}    ${target} = None\n${ctx.indent}else:\n" ++ node.props.value.encode (ctx // { indent = ctx.indent ++ "    " }) value target path
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> "${ctx.indent}if ${value} is None:\n${ctx.indent}    ${target} = None\n${ctx.indent}else:\n" ++ node.props.value.decode (ctx // { indent = ctx.indent ++ "    " }) value target path
                    , pythonType = \(ctx : RenderContext) -> "${node.props.value.pythonType ctx} | None"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , List = \(node : (s.list.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderList True False ctx value target path node.props.values
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderList False False ctx value target path node.props.values
                    , pythonType = \(ctx : RenderContext) -> "list[${node.props.values.pythonType ctx}]"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , Set = \(node : (s.set.nodeF Fragment).Type) ->
                    let isSet = merge { none = True, list = False } node.props.variant
                    in  { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderList True isSet ctx value target path node.props.values
                        , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderList False isSet ctx value target path node.props.values
                        , pythonType = \(ctx : RenderContext) -> "${if isSet then "set" else "list"}[${node.props.values.pythonType ctx}]"
                        , interfaceImplementation = \(_ : Text) -> ""
                        , rootDecode = \(_ : Text) -> "return result\n"
                        }
                , Map = \(node : (s.map.nodeF Fragment).Type) ->
                    let record = merge { none = False, record = True } node.props.variant
                    in  { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderMap True record ctx value target path node.props.keys node.props.values
                        , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderMap False record ctx value target path node.props.keys node.props.values
                        , pythonType = \(ctx : RenderContext) -> "dict[${node.props.keys.pythonType ctx}, ${node.props.values.pythonType ctx}]"
                        , interfaceImplementation = \(_ : Text) -> ""
                        , rootDecode = \(_ : Text) -> "return result\n"
                        }
                , OneOf = \(node : (s.oneOf.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderOneOf True ctx value target path node.props.options
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderOneOf False ctx value target path node.props.options
                    , pythonType = \(ctx : RenderContext) -> "Any"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , AllOf = \(_ : (s.allOf.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(_ : Text) -> \(_ : Text) -> \(path : Text) -> "${ctx.indent}_fail(\"encode\", ${path}, \"unsupported schema AllOf\")\n"
                    , decode = \(ctx : RenderContext) -> \(_ : Text) -> \(_ : Text) -> \(path : Text) -> "${ctx.indent}_fail(\"decode\", ${path}, \"unsupported schema AllOf\")\n"
                    , pythonType = \(_ : RenderContext) -> "Any"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                , Tuple = \(node : (s.tuple.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderTuple True ctx value target path node.props.values
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderTuple False ctx value target path node.props.values
                    , pythonType = \(ctx : RenderContext) -> "tuple[Any, ...]"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return tuple(result)\n"
                    }
                , Record = \(node : RecordNode) ->
                    { encode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderRecord True ctx value target path node.props.required node.props.optional
                    , decode = \(ctx : RenderContext) -> \(value : Text) -> \(target : Text) -> \(path : Text) -> renderRecord False ctx value target path node.props.required node.props.optional
                    , pythonType = \(_ : RenderContext) -> "dict[str, Any]"
                    , interfaceImplementation = renderInterfaceImplementation node
                    , rootDecode = renderRootDecode node
                    }
                , Function = \(_ : (s.function.nodeF Fragment).Type) ->
                    { encode = \(ctx : RenderContext) -> \(_ : Text) -> \(_ : Text) -> \(path : Text) -> "${ctx.indent}_fail(\"encode\", ${path}, \"unsupported schema Function\")\n"
                    , decode = \(ctx : RenderContext) -> \(_ : Text) -> \(_ : Text) -> \(path : Text) -> "${ctx.indent}_fail(\"decode\", ${path}, \"unsupported schema Function\")\n"
                    , pythonType = \(_ : RenderContext) -> "Any"
                    , interfaceImplementation = \(_ : Text) -> ""
                    , rootDecode = \(_ : Text) -> "return result\n"
                    }
                }
                layer

        in  renderer

let renderSchema = s.fold s.typeF Fragment renderSchema

in  renderSchema
