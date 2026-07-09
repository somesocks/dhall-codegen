let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderReference
    : s.reference.node.Type -> RenderFragment
    = \(node : s.reference.node.Type) ->
      \(ctx : RenderContext) ->
        let expression = "${renderPrefix ctx}${node.props.to}" in { expression }

in  renderReference
