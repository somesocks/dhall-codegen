let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let List/zeroOneMany = ../prelude/List/zeroOneMany.dhall

let Optional/default = ../prelude/Optional/default.dhall

let Optional/fold = ../prelude/Optional/fold.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Text/replicate = ../prelude/Text/replicate.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let Document = Grammar.Document

let Renderer = Grammar.Renderer

let liftDefinitions = ../transformer-lift/package.dhall

let quote
    : Text -> Text
    = \(t : Text) -> Text/show t

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let RenderOptions = common.RenderOptions

let TextNode = common.TextNode

let RenderContext = common.RenderContext

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderSchema = ./render-schema.dhall

let renderRootSchema
    : Schema.root.type -> RenderContext -> Text
    = \(root : Schema.root.type) ->
      \(ctx : RenderContext) ->
        let ctx1 = ctx // { depth = ctx.depth + 1 }

        let description = renderDescription root.meta.description ctx

        let definition = renderSchema root.contains ctx1

        let statement =
              ''
              ${description.expression}
              export type ${ctx.options.prefix}${root.meta.name} =${definition.expression};''

        in  statement

let renderDocument
    : RenderOptions -> Renderer
    = \(options : RenderOptions) ->
      \(d : Document.Type) ->
        let d = liftDefinitions.transform liftDefinitions.options::{=} d

        let ctx = { index = 0, depth = 0, options }

        let renderSchemaLine =
              \(index : Natural) ->
              \(schema : Schema.root.type) ->
                let ctx1 = ctx // { index } in renderRootSchema schema ctx1

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "\n\n" renderedSchemas

        let description = (renderDescription d.description ctx).expression

        let headers = Text/concatSep "\n" d.headers

        let footer = ""

        in  Text/concatSep "\n" [ description, headers, body, footer ]

let options =
      { Type = RenderOptions
      , default = { indent = "\t", break = "\n", prefix = "" }
      }

in  { render = renderDocument, options }
