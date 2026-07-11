let List/map = ../prelude/List/map.dhall

let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let Document = Grammar.Document

let Renderer = Grammar.Renderer

let liftDefinitions = ../transformer-lift/package.dhall

let quote
    : Text -> Text
    = \(t : Text) -> Text/show t

let RenderContext =
      { index : Natural, depth : Natural, indent : Text, break : Text }

let ExpressionType = < None | TypeAlias | Class | Protocol >

let TextNode = { expression : Text, type : ExpressionType }

let RenderFragment
    : Type
    = RenderContext -> TextNode

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderSchema = ./render-schema.dhall

let renderRootSchema
    : Schema.root.type -> RenderContext -> Text
    = \(root : Schema.root.type) ->
      \(ctx : RenderContext) ->
        let description =
              merge
                { None = [] : List Text
                , Some =
                    \(description : Text) ->
                      [ (renderDescription (Some description) ctx).expression ]
                }
                root.meta.description

        let definition = renderSchema root.contains ctx

        let statement =
              merge
                { None = ""
                , TypeAlias =
                    Text/concatSep
                      "\n"
                      (description # [ "${root.meta.name}: TypeAlias = ${definition.expression}" ])
                , Class =
                    Text/concatSep
                      "\n"
                      (description # [ "class ${root.meta.name}(BaseModel):${definition.expression}" ])
                , Protocol =
                    Text/concatSep
                      "\n"
                      (description # [ "class ${root.meta.name}(Protocol):${definition.expression}" ])
                }
                definition.type

        in  statement

let imports =
      ''
      from __future__ import annotations

      from datetime import datetime
      from pydantic import BaseModel, Field, TypeAdapter
      from typing import (
          Any, Optional, Union, List, Set, Dict, Tuple, Callable, Literal
      )

      # backports for 3.8:
      from typing_extensions import Annotated, Protocol  # for constraints/validators

      try:
          from typing_extensions import TypeAlias
      except Exception:
          TypeAlias = Any  # fall back; plain assignment still works

      try:
          from types import NoneType          # 3.10+
      except ImportError:
          NoneType = type(None)               # fallback for 3.8–3.9

      # used to simulate intersection type
      def _check_all_of(*adapters: TypeAdapter[Any]):
          def check(v: Any) -> Any:
              for ta in adapters:
                  ta.validate_python(v)  # raises on failure
              return v
          return check

      ''

let renderDocument
    : RenderContext -> Renderer
    = \(ctx : RenderContext) ->
      \(d : Document.Type) ->
        let d = liftDefinitions.transform liftDefinitions.options::{=} d

        let renderSchemaLine =
              \(index : Natural) ->
              \(root : Schema.root.type) ->
                let ctx2 = ctx // { index } in renderRootSchema root ctx2

        let renderedSchemas =
              List/mapWithIndex Schema.root.type Text renderSchemaLine d.schemas

        let body = Text/concatSep "\n\n" renderedSchemas

        let description =
              merge
                { None = [] : List Text
                , Some =
                    \(description : Text) ->
                      [ (renderDescription (Some description) ctx).expression ]
                }
                d.description

        in  Text/concatSep "\n" (description # [ imports ] # d.headers # [ body ])

in  { render =
        renderDocument { index = 0, depth = 0, indent = "    ", break = "\n" }
    }
