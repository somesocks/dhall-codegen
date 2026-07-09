let Text/replicate = ../prelude/Text/replicate.dhall

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix
    : RenderContext -> Text
    = \(context : RenderContext) ->
            context.options.break
        ++  Text/replicate context.depth context.options.indent

in  renderPrefix
