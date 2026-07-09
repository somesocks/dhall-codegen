let renderer = ../../../src/renderer-typescript/package.dhall

let output =
      renderer.render
        renderer.options::{ break = " ", indent = "" }
        ../document.dhall

in  output
