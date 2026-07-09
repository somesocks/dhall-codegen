let renderer = ../../../src/renderer-typescript-zod/package.dhall

let output =
      renderer.render
        renderer.options::{ variant = renderer.variant.ZOD_3 }
        ../document.dhall

in  output
