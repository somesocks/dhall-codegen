let Text/replicate = ../prelude/Text/replicate.dhall

let common = ./common.dhall

let RenderContext = common.RenderContext

let renderPrefix
    : RenderContext -> Text
    = \(context : RenderContext) ->
        "\n" ++ Text/replicate context.depth "\t"

in  renderPrefix
