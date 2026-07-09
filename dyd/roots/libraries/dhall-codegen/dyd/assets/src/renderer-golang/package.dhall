let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let List_fold = ../prelude/List/fold.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let Document = Grammar.Document

let Renderer = Grammar.Renderer

let liftDefinitions = ../transformer-lift/package.dhall

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderOptions = common.RenderOptions

let collectImports = ./collect-imports.dhall

let renderDescription = ./render-description.dhall

let renderSchema = ./render-schema.dhall

let isOneOfLayer
    : Schema.typeF Bool -> Bool
    = \(layer : Schema.typeF Bool) ->
        merge
          { Any = \(x : Schema.any.node.Type) -> False
          , Boolean = \(x : Schema.boolean.node.Type) -> False
          , Number = \(x : Schema.number.node.Type) -> False
          , Text = \(x : Schema.text.node.Type) -> False
          , Time = \(x : Schema.time.node.Type) -> False
          , Reference = \(x : Schema.reference.node.Type) -> False
          , Optional = \(x : (Schema.optional.nodeF Bool).Type) -> False
          , List = \(x : (Schema.list.nodeF Bool).Type) -> False
          , Set = \(x : (Schema.set.nodeF Bool).Type) -> False
          , Map = \(x : (Schema.map.nodeF Bool).Type) -> False
          , OneOf = \(x : (Schema.oneOf.nodeF Bool).Type) -> True
          , AllOf = \(x : (Schema.allOf.nodeF Bool).Type) -> False
          , Tuple = \(x : (Schema.tuple.nodeF Bool).Type) -> False
          , Record = \(x : (Schema.record.nodeF Bool).Type) -> False
          , Function = \(x : (Schema.function.nodeF Bool).Type) -> False
          }
          layer

let isOneOf = Schema.fold Schema.typeF Bool isOneOfLayer

let renderRootSchema
    : Schema.root.type -> RenderContext -> Text
    = \(root : Schema.root.type) ->
      \(ctx : RenderContext) ->
        let ctxNoDesc =
              ctx // { options = ctx.options // { emitDescriptions = False } }

        let oneOfRoot = isOneOf root.contains

        let ctxOneOf =
              if    oneOfRoot
              then  ctxNoDesc // { oneOfName = Some root.meta.name }
              else  ctxNoDesc

        let definition = renderSchema root.contains ctxOneOf

        let comment =
              merge
                { None = ""
                , Some = \(desc : Text) -> (renderDescription (Some desc) ctx).expression ++ "\n"
                }
                root.meta.description

        let statement =
              merge
                { None =
                    comment
                    ++  "type ${ctx.options.prefix}${root.meta.name} ${definition.expression}"
                , Some =
                    \(name : Text) ->
                      comment ++ definition.expression
                }
                ctxOneOf.oneOfName

        in  statement

let renderDocument
    : RenderOptions -> Renderer
    = \(options : RenderOptions) ->
      \(d : Document.Type) ->
        let d =
              liftDefinitions.transform
                liftDefinitions.options::{ liftOneOf = True }
                d

        let ctx = { index = 0, depth = 0, options, oneOfName = None Text }

        let importInfo =
              List_fold
                Schema.root.type
                d.schemas
                collectImports.ImportInfo
                ( \(root : Schema.root.type) ->
                  \(state : collectImports.ImportInfo) ->
                    collectImports.mergeImports
                      state
                      (collectImports.collect root.contains)
                )
                collectImports.empty

        let imports =
              if    importInfo.usesTime
              then  "import \"time\""
              else  ""

        let packageLine =
              merge
                { None = ""
                , Some = \(name : Text) -> "package ${name}"
                }
                options.package

        let packageBlock =
              if    importInfo.usesTime
              then  packageLine ++ "\n"
              else  packageLine

        let renderSchemaLine =
              \(index : Natural) ->
              \(schema : Schema.root.type) ->
                let ctx1 = ctx // { index } in renderRootSchema schema ctx1

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "\n\n" renderedSchemas

        let description =
              merge
                { None = [] : List Text
                , Some =
                    \(desc : Text) ->
                      [ (renderDescription (Some desc) ctx).expression ]
                }
                d.description

        let headers = Text/concatSep "\n" d.headers

        let footer = ""

        let parts = description # [ packageBlock, imports, headers, body, footer ]

        in  Text/concatSep "\n" parts

let options =
      { Type = RenderOptions
      , default = { prefix = "", package = None Text, emitDescriptions = True }
      }

in  { render = renderDocument, options }
