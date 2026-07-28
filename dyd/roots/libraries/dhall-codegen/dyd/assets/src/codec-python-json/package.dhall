let List/map = ../prelude/List/map.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Document = Grammar.Document

let Schema = Grammar.Schema

let liftDefinitions = ../transformer-lift/package.dhall

let renderTypes = ../renderer-python-3.11/package.dhall

let common = ./common.dhall

let renderSchema = ./render-schema.dhall

let renderPrelude = ./render-prelude.dhall

let renderRoot =
      \(root : Schema.root.type) ->
        let name = root.meta.name

        let fragment = renderSchema root.contains

        let ctx = { indent = "    ", label = name }

        let implementation = fragment.interfaceImplementation name

        let encode = fragment.encode ctx "value" "result" "path"

        let decode = fragment.decode ctx "input" "result" "path"

        let rootDecode = fragment.rootDecode name

        in  Text/concatSep
              "\n"
              [ implementation
              , "def _encode_${name}_at(value: ${name}, path: str) -> Any:\n${encode}    return result\n"
              , "def _decode_${name}_at(input: Any, path: str) -> ${name}:\n${decode}    ${rootDecode}"
              , "def encode_${name}(value: ${name}) -> Any:\n    return _encode_${name}_at(value, \"$\")\n"
              , "def decode_${name}(input: Any) -> ${name}:\n    return _decode_${name}_at(input, \"$\")"
              ]

let imports = ''
import base64
import math
import re
from datetime import date, datetime, time
from ipaddress import IPv4Address, IPv6Address, ip_address
from typing import Any
from urllib.parse import urlparse
from uuid import UUID
''

let render : Document.Type -> Text =
      \(document : Document.Type) ->
        let document = liftDefinitions.transform liftDefinitions.options::{=} document

        let types = renderTypes.render document

        let roots = List/map Schema.root.type Text renderRoot document.schemas

        in  Text/concatSep "\n\n" [ types, imports, renderPrelude, Text/concatSep "\n\n" roots ]

in  { render }
