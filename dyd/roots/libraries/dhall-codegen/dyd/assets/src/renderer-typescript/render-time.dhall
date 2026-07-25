let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let TimeMode = common.TimeMode

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderTimeVariant
    : TimeMode -> s.time.variants -> Text
    = \(time : TimeMode) ->
      \(variant : s.time.variants) ->
        merge
          { none = merge { LEGACY = "Date", TEMPORAL = "Temporal.Instant" } time }
          variant

let renderTime
    : s.time.node.Type -> RenderFragment
    = \(node : s.time.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let definition =
              renderPrefix ctx ++ renderTimeVariant ctx.options.time node.props.variant

        let expression = description ++ definition

        in  { expression }

in  renderTime
