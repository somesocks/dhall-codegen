let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let Document = Grammar.Document

let Renderer = Grammar.Renderer

let liftDefinitions = ../transformer-lift/package.dhall

let transformJsonSchema = (../transformer-json-schema/package.dhall).transform

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let Variant = common.Variant

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderSchema = ./render-schema.dhall

let renderRootSchema
    : Schema.root.type → RenderContext → Text
    = λ(root : Schema.root.type) →
      λ(ctx : RenderContext) →
        let render =
              Schema.fold Schema.typeF RenderFragment renderSchema root.contains

        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let description = renderDescription root.meta.description ctx1

        let definition = render ctx1

        let p0 = renderPrefix ctx

        let statement = "${p0}\"${root.meta.name}\":${definition.expression}"

        in  statement

let renderDocument
    : RenderContext → Renderer
    = λ(ctx : RenderContext) →
      λ(d : Document.Type) →
        let d = transformJsonSchema d

        let d = liftDefinitions.transform liftDefinitions.options::{=} d

        let p0 = renderPrefix (ctx ⫽ { depth = 0 })

        let p1 = renderPrefix (ctx ⫽ { depth = 1 })

        let p2 = renderPrefix (ctx ⫽ { depth = 2 })

        let renderSchemaLine =
              λ(index : Natural) →
              λ(schema : Schema.root.type) →
                let ctx2 = ctx ⫽ { depth = 2, index }

                in  renderRootSchema schema ctx2

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "," renderedSchemas

        let schema =
              merge
                { DRAFT_2020_12 = "https://json-schema.org/draft/2020-12/schema"
                , DRAFT_07 = "http://json-schema.org/draft-07/schema#"
                }
                ctx.variant

        let defsKeyword =
              merge
                { DRAFT_2020_12 = "\$defs", DRAFT_07 = "definitions" }
                ctx.variant

        let main =
              merge
                { None = ""
                , Some =
                    λ(main : Text) →
                      "${p1}\"\$ref\": \"#/${defsKeyword}/${main}\","
                }
                ctx.main

        let headers =
                  "${p0}{"
              ++  "${p1}\"\$schema\": \"${schema}\","
              ++  "${p1}\"\$id\": \"https://example.com/schemas/your-file.json\","
              ++  main
              ++  "${p1}\"${defsKeyword}\": {"

        let footer = "${p1}}" ++ "${p0}}"

        in  Text/concatSep "" [ headers, body, footer ]

let Options =
      { Type = RenderContext
      , default =
        { index = 0
        , depth = 0
        , indent = "\t"
        , break = "\n"
        , variant = Variant.DRAFT_2020_12
        , main = None Text
        }
      }

in  { render = renderDocument, options = Options, variant = Variant }
