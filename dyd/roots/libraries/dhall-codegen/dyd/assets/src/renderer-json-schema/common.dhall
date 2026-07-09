let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let Variant = < DRAFT_2020_12 | DRAFT_07 >

let RenderContext =
      { index : Natural
      , depth : Natural
      , indent : Text
      , break : Text
      , variant : Variant
      , main : Optional Text
      }

let TextNode = { expression : Text }

let RenderFragment
    : Type
    = RenderContext → TextNode

in  { RenderContext, TextNode, RenderFragment, Variant }
