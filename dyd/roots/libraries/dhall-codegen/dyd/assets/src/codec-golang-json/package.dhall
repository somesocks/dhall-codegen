let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Schema = Grammar.Schema

let liftDefinitions = ../transformer-lift/package.dhall

let renderTypes = ../renderer-golang/package.dhall

let common = ./common.dhall

let renderSchema = ./render-schema.dhall

let renderPrelude = ./render-prelude.dhall

let indent =
      \(prefix : Text) ->
      \(body : Text) ->
        let marker = "<codec-golang-json-end>"

        let body = Text/replace "\n${marker}" marker (body ++ marker)

        let body = prefix ++ Text/replace "\n" "\n${prefix}" body

        in  Text/replace marker "" body

let renderRoot =
      \(index : Natural) ->
      \(root : Schema.root.type) ->
      \(options : common.RenderOptions) ->
        let typeName = options.prefix ++ root.meta.name

        let fragment = renderSchema root.contains

        let context =
              { options
              , indentation = "\t"
              , rootType = Some root.meta.name
              , label = "Root${Natural/show index}"
              , onError = "return err, result"
              }

        let underlyingType = fragment.goType context

        let encodeBody =
              indent "\t"
                (fragment.encode context "(${underlyingType})(value)" "result" "path")

        let decodeBody =
              indent "\t"
                ( "var decoded ${underlyingType}\n"
                ++ fragment.decode context "input" "decoded" "path"
                ++ "result = ${typeName}(decoded)\n"
                )

        let statement =
              ''
            func Encode${typeName}(value ${typeName}) (err error, result any) {
            	return encode${typeName}At(value, "$")
            }

            func encode${typeName}At(value ${typeName}, path string) (err error, result any) {
            ${encodeBody}
	return nil, result
            }

            func Decode${typeName}(input any) (err error, result ${typeName}) {
            	return decode${typeName}At(input, "$")
            }

            func decode${typeName}At(input any, path string) (err error, result ${typeName}) {
            ${decodeBody}
	return nil, result
            }''

        let statement =
              Text/replace
                "\n            "
                "\n"
                (Text/replace "            func" "func" statement)

        in  Text/concatSep
              "\n\n"
              [ fragment.interfaceImplementation context, statement ]

let renderDocument
    : common.RenderOptions -> Document.Type -> Text
    = \(options : common.RenderOptions) ->
      \(document : Document.Type) ->
        let document =
              liftDefinitions.transform
                liftDefinitions.options::{ liftOneOf = True }
                document

        let typeOptions = options // { package = None Text }

        let types = renderTypes.render typeOptions document

        let types = Text/replace "import \"time\"\n" "" types

        let packageLine =
              merge
                { None = ""
                , Some = \(name : Text) -> "package ${name}"
                }
                options.package

        let rootDefinitions =
              List/mapWithIndex
                Schema.root.type
                Text
                (\(index : Natural) -> \(root : Schema.root.type) -> renderRoot index root options)
                document.schemas

        in  Text/concatSep "\n\n" [ packageLine, renderPrelude, types, Text/concatSep "\n\n" rootDefinitions ]

let options = renderTypes.options

in  { render = renderDocument, options }
