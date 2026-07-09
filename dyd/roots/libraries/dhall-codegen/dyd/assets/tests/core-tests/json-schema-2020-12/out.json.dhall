let renderer = ../../../src/renderer-json-schema/package.dhall

let output = renderer.render renderer.options::{=} ../document.dhall

in  output
