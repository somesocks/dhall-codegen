let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let renderText
    : s.text.node.Type -> RenderFragment
    = \(node : s.text.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition = "string"

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderText
