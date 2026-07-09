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

let renderTypes = ../renderer-typescript/package.dhall

let quote
    : Text -> Text
    = \(t : Text) -> Text/show t

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderOptions = common.RenderOptions

let TextNode = common.TextNode

let RenderFragment = common.RenderFragment

let Variant = common.Variant

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderSchema = ./render-schema.dhall

let renderRootSchema
    : Schema.root.type -> RenderContext -> Text
    = \(root : Schema.root.type) ->
      \(ctx : RenderContext) ->
        let description = renderDescription root.meta.description ctx

        let res = renderSchema root.contains ctx

        let expression = res.expression

        let name = root.meta.name

        let statement =
              merge
                { ZOD_3 =
                    ''
                    ${description.expression}
                    export const ${name} =${expression};
                    export type T${name} = z.infer<typeof ${name}>''
                , ZOD_3_RECURSION =
                    ''
                    ${description.expression}
                    export const ${name} : z.ZodType<T${name}> = z.lazy(() => ${expression});''
                , ZOD_4 =
                    ''
                    ${description.expression}
                    export const ${name} =${expression};
                    export type T${name} = z.infer<typeof ${name}>''
                , ZOD_4_RECURSION =
                    ''
                    ${description.expression}
                    export const ${name} : z.ZodType<T${name}> = z.lazy(() => ${expression});''
                }
                ctx.options.variant

        in  statement

let renderDocument
    : RenderOptions -> Renderer
    = \(options : RenderOptions) ->
      \(d : Document.Type) ->
        let d = liftDefinitions.transform liftDefinitions.options::{=} d

        let ctx = { index = 0, depth = 1, options }

        let renderSchemaLine =
              \(index : Natural) ->
              \(schema : Schema.root.type) ->
                let ctx2 = ctx // { index } in renderRootSchema schema ctx2

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "\n\n" renderedSchemas

        let description = (renderDescription d.description ctx).expression

        let headers = Text/concatSep "\n" d.headers

        let import =
              merge
                { ZOD_3 =
                    ''
                    import { z } from 'zod';
                    ''
                , ZOD_3_RECURSION =
                    ''
                    import { z } from 'zod';
                    ''
                , ZOD_4 =
                    ''
                    import * as z from 'zod';
                    ''
                , ZOD_4_RECURSION =
                    ''
                    import * as z from 'zod';
                    ''
                }
                options.variant

        let standaloneTypes =
              merge
                { ZOD_3 = ""
                , ZOD_3_RECURSION =
                    renderTypes.render
                      renderTypes.options::{
                      , indent = options.indent
                      , break = options.break
                      , prefix = "T"
                      }
                      d
                , ZOD_4 = ""
                , ZOD_4_RECURSION =
                    renderTypes.render
                      renderTypes.options::{
                      , indent = options.indent
                      , break = options.break
                      , prefix = "T"
                      }
                      d
                }
                options.variant

        let footer = ""

        in  Text/concatSep
              "\n"
              [ description, headers, import, standaloneTypes, body, footer ]

let options =
      { Type = RenderOptions
      , default = { indent = "\t", break = "\n", variant = Variant.ZOD_3 }
      }

in  { render = renderDocument, options, variant = Variant }
