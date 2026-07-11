let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let RenderContext =
      { index : Natural, depth : Natural, indent : Text, break : Text }

let ExpressionType = < None | TypeAlias | Class | Protocol >

let TextNode = { expression : Text, type : ExpressionType }

let RenderFragment
    : Type
    = RenderContext -> TextNode

in  { RenderContext, TextNode, ExpressionType, RenderFragment }
