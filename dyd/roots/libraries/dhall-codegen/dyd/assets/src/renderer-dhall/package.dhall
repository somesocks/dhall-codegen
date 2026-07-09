let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let Document = Grammar.Document

let Renderer = Grammar.Renderer

let liftDefinitions = ../transformer-lift/package.dhall

let quote
    : Text → Text
    = λ(t : Text) → Text/show t

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderSchema = ./render-schema.dhall

let renderRootSchemaDefinition
    : RenderContext → Schema.root.type → Text
    = λ(ctx : RenderContext) →
      λ(root : Schema.root.type) →
        let render =
              Schema.fold Schema.typeF RenderFragment renderSchema root.contains

        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let description = renderDescription root.meta.description ctx1

        let definition = render ctx1

        let p1 = renderPrefix ctx

        let statement = "let ${root.meta.name} =${definition.expression}"

        in  statement

let renderExportName
    : RenderContext → Schema.root.type → Text
    = λ(ctx : RenderContext) →
      λ(root : Schema.root.type) →
        let ctx1 = ctx ⫽ { depth = ctx.depth + 1 }

        let p1 = renderPrefix ctx1

        let statement = "${p1}${root.meta.name}"

        in  statement

let renderDocument
    : RenderContext → Renderer
    = λ(ctx : RenderContext) →
      λ(d : Document.Type) →
        let d = liftDefinitions.transform liftDefinitions.options::{=} d

        let renderSchemaLine =
              λ(index : Natural) →
              λ(schema : Schema.root.type) →
                let ctx2 = ctx ⫽ { depth = 0, index }

                in  renderRootSchemaDefinition ctx2 schema

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "\n\n" renderedSchemas

        let exports =
              List/map Schema.root.type Text (renderExportName ctx) d.schemas

        let exports = Text/concatSep "," exports

        let exports =
                  ''


                  in {''
              ++  exports
              ++  ''

                  }''

        let headers =
              ''

              let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

              ''

        let footer = ""

        in  Text/concatSep "" [ headers, body, exports, footer ]

in  { render =
        renderDocument { index = 0, depth = 0, indent = "  ", break = "\n" }
    , renderCompact =
        renderDocument { index = 0, depth = 0, indent = "", break = " " }
    }
