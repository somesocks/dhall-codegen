let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let renderBoolean
    : s.boolean.node.Type -> RenderFragment
    = \(node : s.boolean.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition = "bool"

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderBoolean
