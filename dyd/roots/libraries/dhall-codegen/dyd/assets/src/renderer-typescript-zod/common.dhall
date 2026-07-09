let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let Variant = < ZOD_3 | ZOD_3_RECURSION | ZOD_4 | ZOD_4_RECURSION >

let RenderOptions = { indent : Text, break : Text, variant : Variant }

let RenderContext =
      { index : Natural, depth : Natural, options : RenderOptions }

let TextNode = { expression : Text }

let RenderFragment
    : Type
    = RenderContext -> TextNode

in  { RenderContext, RenderOptions, TextNode, RenderFragment, Variant }
