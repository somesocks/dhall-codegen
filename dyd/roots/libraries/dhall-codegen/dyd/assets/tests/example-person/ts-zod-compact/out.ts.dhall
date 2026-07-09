let renderer = ../../../src/renderer-typescript-zod/package.dhall

let output =
      renderer.render
        renderer.options::{ break = " ", indent = "", variant = renderer.variant.ZOD_3_RECURSION }
        ../document.dhall

in  output
