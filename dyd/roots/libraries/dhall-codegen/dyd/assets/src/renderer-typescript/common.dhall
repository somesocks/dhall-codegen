let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let RenderOptions = { indent : Text, break : Text, prefix : Text }

let RenderContext =
      { index : Natural, depth : Natural, options : RenderOptions }

let TextNode = { expression : Text }

let RenderFragment
    : Type
    = RenderContext -> TextNode

in  { RenderContext, RenderOptions, TextNode, RenderFragment }
