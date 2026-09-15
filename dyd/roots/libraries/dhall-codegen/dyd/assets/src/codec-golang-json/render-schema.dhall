let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let Text/snakeCase = ../utils/Text/snakeCase.dhall

let Fragment
    : Type
    = { encode : RenderContext -> Text -> Text -> Text -> Text
      , decode : RenderContext -> Text -> Text -> Text -> Text
      , goType : RenderContext -> Text
      , name : Optional Text
      , interfaceImplementation : RenderContext -> Text
      }

let quote
    : Text -> Text
    = \(value : Text) -> Text/show value

let indent =
      \(prefix : Text) ->
      \(body : Text) ->
        let marker = "<codec-golang-json-end>"

        let body =
              Text/replace
                ''

                ${marker}''
                marker
                (body ++ marker)

        let body =
                  prefix
              ++  Text/replace
                    "\n"
                    ''

                    ${prefix}''
                    body

        in  Text/replace marker "" body

let block
    : Text -> Text
    = \(body : Text) ->
        ''
        {
        ${indent "\t" body}
        }
        ''

let errCheck =
      \(ctx : RenderContext) ->
        ''
        if err != nil {
        	${ctx.onError}
        }
        ''

let childContext = \(ctx : RenderContext) -> ctx // { rootType = None Text }

let renderSchema
    : s.typeF Fragment -> Fragment
    = \(layer : s.typeF Fragment) ->
        let renderStructType =
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
              \(ctx : RenderContext) ->
                let requiredField =
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        let fieldName = Text/snakeCase field.mapKey

                        in  ''

                            ${"\t"}${fieldName} ${field.mapValue.goType
                                                    ( childContext ctx
                                                    )} `json:"${field.mapKey}"`''

                let optionalField =
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        let fieldName = Text/snakeCase field.mapKey

                        in  ''

                            ${"\t"}${fieldName} *${field.mapValue.goType
                                                     ( childContext ctx
                                                     )} `json:"${field.mapKey},omitempty"`''

                in      "struct {"
                    ++  Text/concat
                          ( List/map
                              { mapKey : Text, mapValue : Fragment }
                              Text
                              requiredField
                              required
                          )
                    ++  Text/concat
                          ( List/map
                              { mapKey : Text, mapValue : Fragment }
                              Text
                              optionalField
                              optional
                          )
                    ++  ''

                        }''

        let renderTupleType =
              \(values : List Fragment) ->
              \(ctx : RenderContext) ->
                let field =
                      \(index : Natural) ->
                      \(value : Fragment) ->
                        let n = Natural/show (index + 1)

                        in  ''

                            ${"\t"}Item${n} ${value.goType
                                                ( childContext ctx
                                                )} `json:"item${n}"`''

                in      "struct {"
                    ++  Text/concat
                          (List/mapWithIndex Fragment Text field values)
                    ++  ''

                        }''

        let renderInterfaceType =
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
              \(ctx : RenderContext) ->
                let requiredMethod =
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        ''

                        ${"\t"}${Text/snakeCase
                                   field.mapKey}() ${field.mapValue.goType
                                                       (childContext ctx)}''

                let optionalMethod =
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        ''

                        ${"\t"}${Text/snakeCase
                                   field.mapKey}() *${field.mapValue.goType
                                                        (childContext ctx)}''

                in      "interface {"
                    ++  Text/concat
                          ( List/map
                              { mapKey : Text, mapValue : Fragment }
                              Text
                              requiredMethod
                              required
                          )
                    ++  Text/concat
                          ( List/map
                              { mapKey : Text, mapValue : Fragment }
                              Text
                              optionalMethod
                              optional
                          )
                    ++  ''

                        }''

        let renderOneOfType =
              \(values : List Fragment) ->
              \(ctx : RenderContext) ->
                let field =
                      \(index : Natural) ->
                      \(value : Fragment) ->
                        let n = Natural/show (index + 1)

                        let optionName =
                              merge
                                { None = "Option${n}"
                                , Some = \(name : Text) -> name
                                }
                                value.name

                        let fieldName = Text/snakeCase optionName

                        in  ''

                            ${"\t"}${fieldName} *${value.goType
                                                     ( childContext ctx
                                                     )} `json:"${optionName},omitempty"`''

                in      ''
                        struct {
                        	Kind string `json:"kind"`''
                    ++  Text/concat
                          (List/mapWithIndex Fragment Text field values)
                    ++  ''

                        }''

        let renderList =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(child : Fragment) ->
                let ctx1 = childContext ctx

                let conversion =
                      if    encode
                      then  child.encode ctx1 "entry" "encodedEntry" "entryPath"
                      else  child.decode
                              ctx1
                              "entries[index]"
                              "decodedEntry"
                              "entryPath"

                let childType = child.goType ctx1

                in  if    encode
                    then  let loop =
                                    ''
                                    entryPath := pathIndex(${path}, index)
                                    ''
                                ++  ''
                                    var encodedEntry any
                                    ''
                                ++  conversion
                                ++  ''
                                    encodedValues[index] = encodedEntry
                                    ''

                          let body =
                                    ''
                                    entries := ${value}
                                    ''
                                ++  ''
                                    encodedValues := make([]any, len(entries))
                                    ''
                                ++  ''
                                    for index, entry := range entries {
                                    ''
                                ++  indent "\t" loop
                                ++  ''

                                    }
                                    ''
                                ++  ''
                                    ${target} = encodedValues
                                    ''

                          in  block body
                    else  let loop =
                                    ''
                                    entryPath := pathIndex(${path}, index)
                                    ''
                                ++  ''
                                    var decodedEntry ${childType}
                                    ''
                                ++  conversion
                                ++  ''
                                    decodedValues[index] = decodedEntry
                                    ''

                          let body =
                                    ''
                                    err, entries := asArray("decode", ${value}, ${path})
                                    ''
                                ++  errCheck ctx
                                ++  ''
                                    decodedValues := make([]${childType}, len(entries))
                                    ''
                                ++  ''
                                    for index := range entries {
                                    ''
                                ++  indent "\t" loop
                                ++  ''

                                    }
                                    ''
                                ++  ''
                                    ${target} = decodedValues
                                    ''

                          in  block body

        let renderTuple =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(values : List Fragment) ->
                let ctx1 = childContext ctx

                let renderEntry =
                      \(index : Natural) ->
                      \(child : Fragment) ->
                        let n = Natural/show (index + 1)

                        let ctx2 =
                                  childContext ctx
                              //  { label = ctx.label ++ "t${n}" }

                        let local = "${ctx.label}Item${n}"

                        in  if    encode
                            then      ''
                                      var encoded${local} any
                                      ''
                                  ++  child.encode
                                        ctx2
                                        "${value}.Item${n}"
                                        "encoded${local}"
                                        "pathIndex(${path}, ${Natural/show
                                                                index})"
                                  ++  ''
                                      encodedItems[${Natural/show
                                                       index}] = encoded${local}
                                      ''
                            else      ''
                                      var decoded${local} ${child.goType ctx2}
                                      ''
                                  ++  child.decode
                                        ctx2
                                        "entries[${Natural/show index}]"
                                        "decoded${local}"
                                        "pathIndex(${path}, ${Natural/show
                                                                index})"
                                  ++  ''
                                      ${target}.Item${n} = decoded${local}
                                      ''

                let body =
                      Text/concat
                        (List/mapWithIndex Fragment Text renderEntry values)

                let length = Natural/show (List/length Fragment values)

                in  if    encode
                    then  block
                            (     ''
                                  encodedItems := make([]any, ${length})
                                  ''
                              ++  body
                              ++  ''
                                  ${target} = encodedItems
                                  ''
                            )
                    else  block
                            (     ''
                                  err, entries := asArray("decode", ${value}, ${path})
                                  ''
                              ++  errCheck ctx
                              ++  ''
                                  if len(entries) != ${length} {
                                  ''
                              ++  ''
                                  	err = codecError("decode", ${path}, "expected tuple of length ${length}")
                                  ''
                              ++  ''
                                  	${ctx.onError}
                                  ''
                              ++  ''
                                  }
                                  ''
                              ++  body
                            )

        let renderMap =
              \(encode : Bool) ->
              \(record : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(keys : Fragment) ->
              \(values : Fragment) ->
                let ctx1 = childContext ctx

                let keyType = keys.goType ctx1

                let valueType = values.goType ctx1

                let encodeKey = keys.encode ctx1 "key" "encodedKey" "entryPath"

                let encodeValue =
                      values.encode ctx1 "entry" "encodedValue" "entryPath"

                let decodeKey =
                      keys.decode ctx1 "rawKey" "decodedKey" "entryPath"

                let decodeValue =
                      values.decode
                        ctx1
                        "rawValue"
                        "decodedMapValue"
                        "entryPath"

                in  if    record
                    then  if    encode
                          then  let loop =
                                          ''
                                          entryPath := pathField(${path}, fmt.Sprint(key))
                                          ''
                                      ++  ''
                                          var encodedKey any
                                          ''
                                      ++  encodeKey
                                      ++  ''
                                          wireKey, ok := encodedKey.(string)
                                          ''
                                      ++  ''
                                          if !ok { err = codecError("encode", ${path}, "record map keys must encode as strings"); ${ctx.onError} }
                                          ''
                                      ++  ''
                                          var encodedValue any
                                          ''
                                      ++  encodeValue
                                      ++  ''
                                          encodedObject[wireKey] = encodedValue
                                          ''

                                in  block
                                      (     ''
                                            encodedObject := make(map[string]any, len(${value}))
                                            ''
                                        ++  ''
                                            for key, entry := range ${value} {
                                            ''
                                        ++  indent "\t" loop
                                        ++  ''

                                            }
                                            ''
                                        ++  ''
                                            ${target} = encodedObject
                                            ''
                                      )
                          else  let loop =
                                          ''
                                          entryPath := pathField(${path}, key)
                                          ''
                                      ++  ''
                                          rawKey := any(key)
                                          ''
                                      ++  ''
                                          var decodedKey ${keyType}
                                          ''
                                      ++  decodeKey
                                      ++  ''
                                          var decodedMapValue ${valueType}
                                          ''
                                      ++  decodeValue
                                      ++  ''
                                          decodedMap[decodedKey] = decodedMapValue
                                          ''

                                in  block
                                      (     ''
                                            err, object := asObject("decode", ${value}, ${path})
                                            ''
                                        ++  errCheck ctx
                                        ++  ''
                                            decodedMap := make(map[${keyType}]${valueType}, len(object))
                                            ''
                                        ++  ''
                                            for key, rawValue := range object {
                                            ''
                                        ++  indent "\t" loop
                                        ++  ''

                                            }
                                            ''
                                        ++  ''
                                            ${target} = decodedMap
                                            ''
                                      )
                    else  if encode
                    then  let loop =
                                    ''
                                    entryPath := pathField(${path}, fmt.Sprint(key))
                                    ''
                                ++  ''
                                    var encodedKey any
                                    ''
                                ++  encodeKey
                                ++  ''
                                    var encodedValue any
                                    ''
                                ++  encodeValue
                                ++  ''
                                    encodedEntries = append(encodedEntries, map[string]any{"key": encodedKey, "value": encodedValue})
                                    ''

                          in  block
                                (     ''
                                      encodedEntries := make([]any, 0, len(${value}))
                                      ''
                                  ++  ''
                                      for key, entry := range ${value} {
                                      ''
                                  ++  indent "\t" loop
                                  ++  ''

                                      }
                                      ''
                                  ++  ''
                                      ${target} = encodedEntries
                                      ''
                                )
                    else  let loop =
                                    ''
                                    entryPath := pathIndex(${path}, index)
                                    ''
                                ++  ''
                                    entryObject, ok := entry.(map[string]any)
                                    ''
                                ++  ''
                                    if !ok { err = codecError("decode", entryPath, "expected map entry"); ${ctx.onError} }
                                    ''
                                ++  ''
                                    rawKey, hasKey := entryObject["key"]
                                    ''
                                ++  ''
                                    rawValue, hasValue := entryObject["value"]
                                    ''
                                ++  ''
                                    if !hasKey || !hasValue { err = codecError("decode", entryPath, "expected map entry"); ${ctx.onError} }
                                    ''
                                ++  ''
                                    var decodedKey ${keyType}
                                    ''
                                ++  keys.decode
                                      ctx1
                                      "rawKey"
                                      "decodedKey"
                                      "pathField(entryPath, \"key\")"
                                ++  ''
                                    var decodedMapValue ${valueType}
                                    ''
                                ++  values.decode
                                      ctx1
                                      "rawValue"
                                      "decodedMapValue"
                                      "pathField(entryPath, \"value\")"
                                ++  ''
                                    decodedMap[decodedKey] = decodedMapValue
                                    ''

                          in  block
                                (     ''
                                      err, entries := asArray("decode", ${value}, ${path})
                                      ''
                                  ++  errCheck ctx
                                  ++  ''
                                      decodedMap := make(map[${keyType}]${valueType}, len(entries))
                                      ''
                                  ++  ''
                                      for index, entry := range entries {
                                      ''
                                  ++  indent "\t" loop
                                  ++  ''

                                      }
                                      ''
                                  ++  ''
                                      ${target} = decodedMap
                                      ''
                                )

        let renderRecord =
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
                        let ctx1 =
                                  childContext ctx
                              //  { label =
                                      ctx.label ++ "r${Natural/show index}"
                                  }

                        let fieldName = Text/snakeCase field.mapKey

                        let key = quote field.mapKey

                        in  if    encode
                            then  block
                                    (     ''
                                          var encodedField any
                                          ''
                                      ++  field.mapValue.encode
                                            ctx1
                                            "${value}.${fieldName}"
                                            "encodedField"
                                            "pathField(${path}, ${key})"
                                      ++  ''
                                          encodedObject[${key}] = encodedField
                                          ''
                                    )
                            else  block
                                    (     ''
                                          rawValue, exists := object[${key}]
                                          ''
                                      ++  ''
                                          if !exists {
                                          ''
                                      ++  ''
                                          	err = codecError("decode", pathField(${path}, ${key}), "missing required field")
                                          ''
                                      ++  ''
                                          	${ctx.onError}
                                          ''
                                      ++  ''
                                          }
                                          ''
                                      ++  field.mapValue.decode
                                            ctx1
                                            "rawValue"
                                            "${target}.${fieldName}"
                                            "pathField(${path}, ${key})"
                                    )

                let renderOptional =
                      \(index : Natural) ->
                      \(field : { mapKey : Text, mapValue : Fragment }) ->
                        let ctx1 =
                                  childContext ctx
                              //  { label =
                                      ctx.label ++ "o${Natural/show index}"
                                  }

                        let fieldName = Text/snakeCase field.mapKey

                        let key = quote field.mapKey

                        let childType = field.mapValue.goType ctx1

                        in  if    encode
                            then      ''
                                      if ${value}.${fieldName} != nil {
                                      ''
                                  ++  indent
                                        "\t"
                                        (     ''
                                              var encodedField any
                                              ''
                                          ++  field.mapValue.encode
                                                ctx1
                                                "*${value}.${fieldName}"
                                                "encodedField"
                                                "pathField(${path}, ${key})"
                                          ++  ''
                                              encodedObject[${key}] = encodedField
                                              ''
                                        )
                                  ++  ''

                                      }
                                      ''
                            else      ''
                                      if rawValue, exists := object[${key}]; exists && rawValue != nil {
                                      ''
                                  ++  indent
                                        "\t"
                                        (     ''
                                              var decodedValue ${childType}
                                              ''
                                          ++  field.mapValue.decode
                                                ctx1
                                                "rawValue"
                                                "decodedValue"
                                                "pathField(${path}, ${key})"
                                          ++  ''
                                              ${target}.${fieldName} = &decodedValue
                                              ''
                                        )
                                  ++  ''

                                      }
                                      ''

                let fields =
                        List/mapWithIndex
                          { mapKey : Text, mapValue : Fragment }
                          Text
                          renderRequired
                          required
                      # List/mapWithIndex
                          { mapKey : Text, mapValue : Fragment }
                          Text
                          renderOptional
                          optional

                let empty = Natural/isZero (List/length Text fields)

                let fields = Text/concat fields

                let discardObject =
                      if    empty
                      then  ''
                            _ = object
                            ''
                      else  ""

                in  if    encode
                    then  block
                            (     ''
                                  encodedObject := make(map[string]any)
                                  ''
                              ++  fields
                              ++  ''
                                  ${target} = encodedObject
                                  ''
                            )
                    else  block
                            (     ''
                                  err, object := asObject("decode", ${value}, ${path})
                                  ''
                              ++  errCheck ctx
                              ++  discardObject
                              ++  fields
                            )

        let renderInterfaceImplementation =
              \(ctx : RenderContext) ->
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
                merge
                  { None = ""
                  , Some =
                      \(name : Text) ->
                        let implementation =
                              "codec${ctx.options.prefix}${name}Impl"

                        let renderField =
                              \(optional : Bool) ->
                              \ ( field
                                : { mapKey : Text, mapValue : Fragment }
                                ) ->
                                let fieldName = Text/snakeCase field.mapKey

                                let fieldType =
                                      field.mapValue.goType (childContext ctx)

                                let pointer = if optional then "*" else ""

                                in  ''

                                    ${"\t"}Value${fieldName} ${pointer}${fieldType}''

                        let renderMethod =
                              \(optional : Bool) ->
                              \ ( field
                                : { mapKey : Text, mapValue : Fragment }
                                ) ->
                                let fieldName = Text/snakeCase field.mapKey

                                let fieldType =
                                      field.mapValue.goType (childContext ctx)

                                let pointer = if optional then "*" else ""

                                in  ''
                                    func (value ${implementation}) ${fieldName}() ${pointer}${fieldType} {
                                    	return value.Value${fieldName}
                                    }''

                        let requiredFields =
                              List/map
                                { mapKey : Text, mapValue : Fragment }
                                Text
                                (renderField False)
                                required

                        let optionalFields =
                              List/map
                                { mapKey : Text, mapValue : Fragment }
                                Text
                                (renderField True)
                                optional

                        let requiredMethods =
                              List/map
                                { mapKey : Text, mapValue : Fragment }
                                Text
                                (renderMethod False)
                                required

                        let optionalMethods =
                              List/map
                                { mapKey : Text, mapValue : Fragment }
                                Text
                                (renderMethod True)
                                optional

                        in      "type ${implementation} struct {"
                            ++  Text/concat requiredFields
                            ++  Text/concat optionalFields
                            ++  ''

                                }

                                ''
                            ++  Text/concatSep
                                  "\n\n"
                                  (requiredMethods # optionalMethods)
                  }
                  ctx.rootType

        let renderInterfaceRecord =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(required : List { mapKey : Text, mapValue : Fragment }) ->
              \(optional : List { mapKey : Text, mapValue : Fragment }) ->
                merge
                  { None =
                      ''
                      err = codecError("codec", ${path}, "nested interface record is unsupported")
                      ${errCheck ctx}''
                  , Some =
                      \(name : Text) ->
                        let implementation =
                              "codec${ctx.options.prefix}${name}Impl"

                        let renderRequired =
                              \(index : Natural) ->
                              \ ( field
                                : { mapKey : Text, mapValue : Fragment }
                                ) ->
                                let ctx1 =
                                          childContext ctx
                                      //  { label =
                                                  ctx.label
                                              ++  "i${Natural/show index}"
                                          }

                                let fieldName = Text/snakeCase field.mapKey

                                let key = quote field.mapKey

                                in  if    encode
                                    then  block
                                            (     ''
                                                  var encodedField any
                                                  ''
                                              ++  field.mapValue.encode
                                                    ctx1
                                                    "${value}.${fieldName}()"
                                                    "encodedField"
                                                    "pathField(${path}, ${key})"
                                              ++  ''
                                                  encodedObject[${key}] = encodedField
                                                  ''
                                            )
                                    else  block
                                            (     ''
                                                  rawValue, exists := object[${key}]
                                                  ''
                                              ++  ''
                                                  if !exists {
                                                  ''
                                              ++  ''
                                                  	err = codecError("decode", pathField(${path}, ${key}), "missing required field")
                                                  ''
                                              ++  ''
                                                  	${ctx.onError}
                                                  ''
                                              ++  ''
                                                  }
                                                  ''
                                              ++  field.mapValue.decode
                                                    ctx1
                                                    "rawValue"
                                                    "implementation.Value${fieldName}"
                                                    "pathField(${path}, ${key})"
                                            )

                        let renderOptional =
                              \(index : Natural) ->
                              \ ( field
                                : { mapKey : Text, mapValue : Fragment }
                                ) ->
                                let ctx1 =
                                          childContext ctx
                                      //  { label =
                                                  ctx.label
                                              ++  "j${Natural/show index}"
                                          }

                                let fieldName = Text/snakeCase field.mapKey

                                let key = quote field.mapKey

                                let fieldType = field.mapValue.goType ctx1

                                in  if    encode
                                    then      ''
                                              if ${value}.${fieldName}() != nil {
                                              ''
                                          ++  indent
                                                "\t"
                                                (     ''
                                                      var encodedField any
                                                      ''
                                                  ++  field.mapValue.encode
                                                        ctx1
                                                        "*${value}.${fieldName}()"
                                                        "encodedField"
                                                        "pathField(${path}, ${key})"
                                                  ++  ''
                                                      encodedObject[${key}] = encodedField
                                                      ''
                                                )
                                          ++  ''

                                              }
                                              ''
                                    else      ''
                                              if rawValue, exists := object[${key}]; exists && rawValue != nil {
                                              ''
                                          ++  indent
                                                "\t"
                                                (     ''
                                                      var decodedValue ${fieldType}
                                                      ''
                                                  ++  field.mapValue.decode
                                                        ctx1
                                                        "rawValue"
                                                        "decodedValue"
                                                        "pathField(${path}, ${key})"
                                                  ++  ''
                                                      implementation.Value${fieldName} = &decodedValue
                                                      ''
                                                )
                                          ++  ''

                                              }
                                              ''

                        let fields =
                                List/mapWithIndex
                                  { mapKey : Text, mapValue : Fragment }
                                  Text
                                  renderRequired
                                  required
                              # List/mapWithIndex
                                  { mapKey : Text, mapValue : Fragment }
                                  Text
                                  renderOptional
                                  optional

                        let empty = Natural/isZero (List/length Text fields)

                        let fields = Text/concat fields

                        let discardObject =
                              if    empty
                              then  ''
                                    _ = object
                                    ''
                              else  ""

                        in  if    encode
                            then  block
                                    (     ''
                                          encodedObject := make(map[string]any)
                                          ''
                                      ++  fields
                                      ++  ''
                                          ${target} = encodedObject
                                          ''
                                    )
                            else  block
                                    (     ''
                                          err, object := asObject("decode", ${value}, ${path})
                                          ''
                                      ++  errCheck ctx
                                      ++  discardObject
                                      ++  ''
                                          implementation := ${implementation}{}
                                          ''
                                      ++  fields
                                      ++  ''
                                          ${target} = implementation
                                          ''
                                    )
                  }
                  ctx.rootType

        let renderOneOf =
              \(encode : Bool) ->
              \(ctx : RenderContext) ->
              \(value : Text) ->
              \(target : Text) ->
              \(path : Text) ->
              \(options : List Fragment) ->
                let renderEncodeOption =
                      \(index : Natural) ->
                      \(option : Fragment) ->
                        let n = Natural/show (index + 1)

                        let optionName =
                              merge
                                { None = "Option${n}"
                                , Some = \(name : Text) -> name
                                }
                                option.name

                        let fieldName = Text/snakeCase optionName

                        let kind =
                              merge
                                { None = quote optionName
                                , Some =
                                    \(name : Text) ->
                                          ctx.options.prefix
                                      ++  name
                                      ++  "Kind${fieldName}"
                                }
                                ctx.rootType

                        in      ''
                                case ${kind}:
                                ''
                            ++  indent
                                  "\t"
                                  (     ''
                                        if ${value}.${fieldName} == nil {
                                        ''
                                    ++  indent
                                          "\t"
                                          (     ''
                                                err = codecError("encode", ${path}, "malformed union struct: nil ${fieldName} field")
                                                ''
                                            ++  ''
                                                ${ctx.onError}
                                                ''
                                          )
                                    ++  ''

                                        }
                                        ''
                                    ++  option.encode
                                          (     childContext ctx
                                            //  { label = ctx.label ++ "e${n}" }
                                          )
                                          "*${value}.${fieldName}"
                                          target
                                          path
                                  )
                            ++  "\n"

                let renderDecodeOption =
                      \(index : Natural) ->
                      \(option : Fragment) ->
                        let n = Natural/show (index + 1)

                        let optionName =
                              merge
                                { None = "Option${n}"
                                , Some = \(name : Text) -> name
                                }
                                option.name

                        let fieldName = Text/snakeCase optionName

                        let label = "oneOf${ctx.label}Option${n}"

                        let branchContext =
                                  childContext ctx
                              //  { label = ctx.label ++ "d${n}"
                                  , onError = "break ${label}"
                                  }

                        let resultType =
                              merge
                                { None = renderOneOfType options ctx
                                , Some =
                                    \(name : Text) -> ctx.options.prefix ++ name
                                }
                                ctx.rootType

                        let kind =
                              merge
                                { None = quote optionName
                                , Some =
                                    \(name : Text) ->
                                          ctx.options.prefix
                                      ++  name
                                      ++  "Kind${fieldName}"
                                }
                                ctx.rootType

                        let branch =
                                  ''
                                  ${label}:
                                  ''
                              ++  ''
                                  for {
                                  ''
                              ++  indent
                                    "\t"
                                    (     ''
                                          var decodedOption ${option.goType
                                                                branchContext}
                                          ''
                                      ++  option.decode
                                            branchContext
                                            value
                                            "decodedOption"
                                            path
                                      ++  ''
                                          ${target} = ${resultType}{Kind: ${kind}, ${fieldName}: &decodedOption}
                                          ''
                                      ++  ''
                                          matched = true
                                          ''
                                      ++  ''
                                          break ${label}
                                          ''
                                    )
                              ++  ''

                                  }
                                  ''

                        in      ''
                                if !matched {
                                ''
                            ++  indent "\t" branch
                            ++  ''

                                }
                                ''

                in  if    encode
                    then  block
                            (     ''
                                  switch ${value}.Kind {
                                  ''
                              ++  Text/concat
                                    ( List/mapWithIndex
                                        Fragment
                                        Text
                                        renderEncodeOption
                                        options
                                    )
                              ++  ''
                                  default:
                                  ''
                              ++  indent
                                    "\t"
                                    (     ''
                                          err = codecError("encode", ${path}, "malformed union struct: Kind is missing or unknown")
                                          ''
                                      ++  ''
                                          ${ctx.onError}
                                          ''
                                    )
                              ++  "\n"
                              ++  ''
                                  }
                                  ''
                            )
                    else  block
                            (     ''
                                  matched := false
                                  ''
                              ++  Text/concat
                                    ( List/mapWithIndex
                                        Fragment
                                        Text
                                        renderDecodeOption
                                        options
                                    )
                              ++  ''
                                  if !matched {
                                  ''
                              ++  ''
                                  	err = codecError("decode", ${path}, "no OneOf option matched")
                                  ''
                              ++  ''
                                  	${ctx.onError}
                                  ''
                              ++  ''
                                  }
                                  ''
                            )

        let renderer =
              merge
                { Any =
                    \(node : s.any.node.Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = validateAny("encode", ${value}, ${path})
                            ${errCheck ctx}''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = validateAny("decode", ${value}, ${path})
                            ${errCheck ctx}''
                      , goType = \(_ : RenderContext) -> "any"
                      , name = node.meta.name
                      }
                , Boolean =
                    \(node : s.boolean.node.Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = encodeBoolean(${value}, ${path})
                            ${errCheck ctx}''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = decodeBoolean(${value}, ${path})
                            ${errCheck ctx}''
                      , goType = \(_ : RenderContext) -> "bool"
                      , name = node.meta.name
                      }
                , Number =
                    \(node : s.number.node.Type) ->
                      let natural =
                            merge
                              { none = False
                              , natural = True
                              , integer = False
                              , decimal = False
                              }
                              node.props.variant

                      let integer =
                            merge
                              { none = False
                              , natural = True
                              , integer = True
                              , decimal = False
                              }
                              node.props.variant

                      in  { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                if    integer
                                then  ''
                                      err, ${target} = encodeInteger(${value}, ${if    natural
                                                                                 then  "true"
                                                                                 else  "false"}, ${path})
                                      ${errCheck ctx}''
                                else  ''
                                      err, ${target} = encodeFloat(${value}, ${path})
                                      ${errCheck ctx}''
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                if    integer
                                then  ''
                                      err, ${target} = decodeInteger(${value}, ${if    natural
                                                                                 then  "true"
                                                                                 else  "false"}, ${path})
                                      ${errCheck ctx}''
                                else  ''
                                      err, ${target} = decodeFloat(${value}, ${path})
                                      ${errCheck ctx}''
                          , goType =
                              \(_ : RenderContext) ->
                                if integer then "int" else "float64"
                          , name = node.meta.name
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
                              , literal = \(text : Text) -> "literal:${text}"
                              }
                              node.props.variant

                      in  { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                ''
                                err, ${target} = encodeText(${quote
                                                                variant}, ${value}, ${path})
                                ${errCheck ctx}''
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                ''
                                err, ${target} = decodeText(${quote
                                                                variant}, ${value}, ${path})
                                ${errCheck ctx}''
                          , goType = \(_ : RenderContext) -> "string"
                          , name = node.meta.name
                          }
                , Time =
                    \(node : s.time.node.Type) ->
                      let function =
                            merge
                              { none = "Instant"
                              , date = "Date"
                              , time = "LocalTime"
                              , duration = "Duration"
                              }
                              node.props.variant

                      let stringTime =
                            merge
                              { none = False
                              , date = False
                              , time = False
                              , duration = True
                              }
                              node.props.variant

                      in  { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                ''
                                err, ${target} = encode${function}(${value}, ${path})
                                ${errCheck ctx}''
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                ''
                                err, ${target} = decode${function}(${value}, ${path})
                                ${errCheck ctx}''
                          , goType =
                              \(_ : RenderContext) ->
                                if stringTime then "string" else "time.Time"
                          , name = node.meta.name
                          }
                , Reference =
                    \(node : s.reference.node.Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = encode${ctx.options.prefix}${node.props.to}At(${value}, ${path})
                            ${errCheck ctx}''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            err, ${target} = decode${ctx.options.prefix}${node.props.to}At(${value}, ${path})
                            ${errCheck ctx}''
                      , goType =
                          \(ctx : RenderContext) ->
                            ctx.options.prefix ++ node.props.to
                      , name = node.meta.name
                      }
                , Optional =
                    \(node : (s.optional.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            if ${value} == nil {
                            ${target} = nil
                            } else {
                            ${node.props.value.encode
                                (childContext ctx)
                                "(*(${value}))"
                                target
                                path}}
                            ''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            ''
                            if ${value} == nil {
                            ${target} = nil
                            } else {
                            var decodedOptionalValue ${node.props.value.goType
                                                         (childContext ctx)}
                            ${node.props.value.decode
                                (childContext ctx)
                                value
                                "decodedOptionalValue"
                                path}${target} = &decodedOptionalValue
                            }
                            ''
                      , goType =
                          \(ctx : RenderContext) ->
                            "*${node.props.value.goType (childContext ctx)}"
                      , name = node.meta.name
                      }
                , List =
                    \(node : (s.list.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderList
                              True
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderList
                              False
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , goType =
                          \(ctx : RenderContext) ->
                            "[]${node.props.values.goType (childContext ctx)}"
                      , name = node.meta.name
                      }
                , Set =
                    \(node : (s.set.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderList
                              True
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderList
                              False
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , goType =
                          \(ctx : RenderContext) ->
                            "[]${node.props.values.goType (childContext ctx)}"
                      , name = node.meta.name
                      }
                , Map =
                    \(node : (s.map.nodeF Fragment).Type) ->
                      let record =
                            merge
                              { none = False, record = True }
                              node.props.variant

                      in  { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                renderMap
                                  True
                                  record
                                  ctx
                                  value
                                  target
                                  path
                                  node.props.keys
                                  node.props.values
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                renderMap
                                  False
                                  record
                                  ctx
                                  value
                                  target
                                  path
                                  node.props.keys
                                  node.props.values
                          , goType =
                              \(ctx : RenderContext) ->
                                "map[${node.props.keys.goType
                                         ( childContext ctx
                                         )}]${node.props.values.goType
                                                (childContext ctx)}"
                          , name = node.meta.name
                          }
                , OneOf =
                    \(node : (s.oneOf.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderOneOf
                              True
                              ctx
                              value
                              target
                              path
                              node.props.options
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderOneOf
                              False
                              ctx
                              value
                              target
                              path
                              node.props.options
                      , goType =
                          \(ctx : RenderContext) ->
                            merge
                              { None = renderOneOfType node.props.options ctx
                              , Some =
                                  \(name : Text) -> ctx.options.prefix ++ name
                              }
                              ctx.rootType
                      , name = node.meta.name
                      }
                , AllOf =
                    \(node : (s.allOf.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(_ : Text) ->
                          \(_ : Text) ->
                          \(path : Text) ->
                            ''
                            err = codecError("encode", ${path}, "unsupported schema AllOf")
                            ${errCheck ctx}''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(_ : Text) ->
                          \(_ : Text) ->
                          \(path : Text) ->
                            ''
                            err = codecError("decode", ${path}, "unsupported schema AllOf")
                            ${errCheck ctx}''
                      , goType = \(_ : RenderContext) -> "any"
                      , name = node.meta.name
                      }
                , Tuple =
                    \(node : (s.tuple.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderTuple
                              True
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , decode =
                          \(ctx : RenderContext) ->
                          \(value : Text) ->
                          \(target : Text) ->
                          \(path : Text) ->
                            renderTuple
                              False
                              ctx
                              value
                              target
                              path
                              node.props.values
                      , goType =
                          \(ctx : RenderContext) ->
                            renderTupleType node.props.values ctx
                      , name = node.meta.name
                      }
                , Record =
                    \(node : (s.record.nodeF Fragment).Type) ->
                      let interface =
                            merge
                              { none = False, interface = True }
                              node.props.variant

                      in  { encode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                if    interface
                                then  renderInterfaceRecord
                                        True
                                        ctx
                                        value
                                        target
                                        path
                                        node.props.required
                                        node.props.optional
                                else  renderRecord
                                        True
                                        ctx
                                        value
                                        target
                                        path
                                        node.props.required
                                        node.props.optional
                          , decode =
                              \(ctx : RenderContext) ->
                              \(value : Text) ->
                              \(target : Text) ->
                              \(path : Text) ->
                                if    interface
                                then  renderInterfaceRecord
                                        False
                                        ctx
                                        value
                                        target
                                        path
                                        node.props.required
                                        node.props.optional
                                else  renderRecord
                                        False
                                        ctx
                                        value
                                        target
                                        path
                                        node.props.required
                                        node.props.optional
                          , goType =
                              \(ctx : RenderContext) ->
                                if    interface
                                then  renderInterfaceType
                                        node.props.required
                                        node.props.optional
                                        ctx
                                else  renderStructType
                                        node.props.required
                                        node.props.optional
                                        ctx
                          , name = node.meta.name
                          }
                , Function =
                    \(node : (s.function.nodeF Fragment).Type) ->
                      { encode =
                          \(ctx : RenderContext) ->
                          \(_ : Text) ->
                          \(_ : Text) ->
                          \(path : Text) ->
                            ''
                            err = codecError("encode", ${path}, "unsupported schema Function")
                            ${errCheck ctx}''
                      , decode =
                          \(ctx : RenderContext) ->
                          \(_ : Text) ->
                          \(_ : Text) ->
                          \(path : Text) ->
                            ''
                            err = codecError("decode", ${path}, "unsupported schema Function")
                            ${errCheck ctx}''
                      , goType = \(_ : RenderContext) -> "any"
                      , name = node.meta.name
                      }
                }
                layer

        let interfaceImplementation =
              merge
                { Any = \(_ : s.any.node.Type) -> \(_ : RenderContext) -> ""
                , Boolean =
                    \(_ : s.boolean.node.Type) -> \(_ : RenderContext) -> ""
                , Number =
                    \(_ : s.number.node.Type) -> \(_ : RenderContext) -> ""
                , Text = \(_ : s.text.node.Type) -> \(_ : RenderContext) -> ""
                , Time = \(_ : s.time.node.Type) -> \(_ : RenderContext) -> ""
                , Reference =
                    \(_ : s.reference.node.Type) -> \(_ : RenderContext) -> ""
                , Optional =
                    \(_ : (s.optional.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , List =
                    \(_ : (s.list.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , Set =
                    \(_ : (s.set.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , Map =
                    \(_ : (s.map.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , OneOf =
                    \(_ : (s.oneOf.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , AllOf =
                    \(_ : (s.allOf.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , Tuple =
                    \(_ : (s.tuple.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                , Record =
                    \(node : (s.record.nodeF Fragment).Type) ->
                      let interface =
                            merge
                              { none = False, interface = True }
                              node.props.variant

                      in  \(ctx : RenderContext) ->
                            if    interface
                            then  renderInterfaceImplementation
                                    ctx
                                    node.props.required
                                    node.props.optional
                            else  ""
                , Function =
                    \(_ : (s.function.nodeF Fragment).Type) ->
                    \(_ : RenderContext) ->
                      ""
                }
                layer

        in  renderer // { interfaceImplementation }

let renderSchema = s.fold s.typeF Fragment renderSchema

in  renderSchema
