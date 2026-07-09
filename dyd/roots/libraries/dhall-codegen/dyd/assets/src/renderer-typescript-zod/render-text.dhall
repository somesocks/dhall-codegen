let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderTextVariant
    : s.text.variants -> Text
    = \(variant : s.text.variants) ->
        merge
          { none = "z.string()"
          , email = "z.email()"
          , url = "z.url()"
          , literal = \(x : Text) -> "z.literal(\"${x}\")"
          }
          variant

let renderText
    : s.text.node.Type -> RenderFragment
    = \(node : s.text.node.Type) ->
      \(ctx : RenderContext) ->
        let string = renderTextVariant node.props.variant

        let description = renderZodDescription node.meta.description

        let definition = renderPrefix ctx ++ string

        let expression = definition ++ description

        in  { expression }

in  renderText
