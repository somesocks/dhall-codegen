let renderer = ../../../src/renderer-typescript/package.dhall

let output = renderer.render renderer.options::{=} ../document.dhall

in  output
