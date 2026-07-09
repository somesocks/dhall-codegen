let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderTimeVariant
    : s.time.variants -> Text
    = \(variant : s.time.variants) -> merge { none = "Date" } variant

let renderTime
    : s.time.node.Type -> RenderFragment
    = \(node : s.time.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition =
              renderPrefix ctx ++ renderTimeVariant node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderTime
