let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let RenderContext =
      { index : Natural, depth : Natural, indent : Text, break : Text }

let TextNode = { expression : Text, name : Optional Text }

let RenderFragment
    : Type
    = RenderContext → TextNode

in  { RenderContext, TextNode, RenderFragment }
