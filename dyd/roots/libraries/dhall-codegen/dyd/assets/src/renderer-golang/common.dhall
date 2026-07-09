let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let RenderOptions =
      { prefix : Text
      , package : Optional Text
      , emitDescriptions : Bool
      }

let RenderContext =
      { index : Natural
      , depth : Natural
      , options : RenderOptions
      , oneOfName : Optional Text
      }

let TextNode = { expression : Text, name : Optional Text }

let RenderFragment
    : Type
    = RenderContext -> TextNode

in  { RenderContext, RenderOptions, TextNode, RenderFragment }
