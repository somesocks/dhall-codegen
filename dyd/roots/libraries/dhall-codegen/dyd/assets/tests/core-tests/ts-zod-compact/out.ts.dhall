let renderer = ../../../src/renderer-typescript-zod/package.dhall

let output =
      renderer.render
        renderer.options::{ break = " ", indent = "" }
        ../document.dhall

in  output
