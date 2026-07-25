let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let TimeMode = < LEGACY | TEMPORAL >

let RenderOptions = { indent : Text, break : Text, prefix : Text, time : TimeMode }

let RenderContext =
      { index : Natural, depth : Natural, options : RenderOptions }

let TextNode = { expression : Text }

let RenderFragment
    : Type
    = RenderContext -> TextNode

in  { TimeMode, RenderContext, RenderOptions, TextNode, RenderFragment }
