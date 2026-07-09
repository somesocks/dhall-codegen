let renderer = ../../../src/renderer-golang/package.dhall

let output =
      renderer.render
        renderer.options::{ package = Some "models" }
        ../document.dhall

in  output
