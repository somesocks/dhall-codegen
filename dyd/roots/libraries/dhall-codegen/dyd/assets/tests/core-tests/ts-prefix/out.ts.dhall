let renderer = ../../../src/renderer-typescript/package.dhall

let output =
      renderer.render renderer.options::{ prefix = "T" } ../document.dhall

in  output
