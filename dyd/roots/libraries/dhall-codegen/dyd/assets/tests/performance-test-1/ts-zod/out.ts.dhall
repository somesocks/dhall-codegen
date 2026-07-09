let renderer = ../../../src/renderer-typescript-zod/package.dhall

let output = renderer.render renderer.options::{=} ../document.dhall

in  output
