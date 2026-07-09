let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let renderAny
    : s.any.node.Type -> RenderFragment
    = \(node : s.any.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition = "interface{}"

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderAny
