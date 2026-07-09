let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderReference
    : Schema.reference.node.Type -> RenderFragment
    = \(node : Schema.reference.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition = renderPrefix ctx ++ ctx.options.prefix ++ node.props.to

        let expression = description ++ definition

        in  { expression }

in  renderReference
