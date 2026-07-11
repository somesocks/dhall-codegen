let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderTextVariant
    : s.text.variants -> Text
    = \(variant : s.text.variants) ->
        merge
          { none = "str"
          , email = "str"
          , url = "str"
          , literal = \(x : Text) -> "Literal['${x}']"
          }
          variant

let renderText
    : s.text.node.Type -> RenderFragment
    = \(node : s.text.node.Type) ->
      \(ctx : RenderContext) ->
        let description = ""

        let definition = renderTextVariant node.props.variant

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderText
