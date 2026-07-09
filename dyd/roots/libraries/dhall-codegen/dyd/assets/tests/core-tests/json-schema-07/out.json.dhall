let renderer = ../../../src/renderer-json-schema/package.dhall

let output =
      renderer.render
        renderer.options::{
        , variant = renderer.variant.DRAFT_07
        , main = Some "Person"
        }
        ../document.dhall

in  output
