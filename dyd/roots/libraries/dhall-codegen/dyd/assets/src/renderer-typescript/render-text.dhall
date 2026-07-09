let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderTextVariant
    : s.text.variants -> Text
    = \(variant : s.text.variants) ->
        merge
          { none = "string"
          , email = "string"
          , url = "string"
          , literal = \(x : Text) -> "\"${x}\""
          }
          variant

let renderText
    : s.text.node.Type -> RenderFragment
    = \(node : s.text.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition =
              renderPrefix ctx ++ renderTextVariant node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderText
