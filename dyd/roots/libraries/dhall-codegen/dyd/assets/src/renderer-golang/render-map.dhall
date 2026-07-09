let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let MapNode = (Schema.map.nodeF RenderFragment).Type

let renderMap
    : MapNode -> RenderFragment
    = \(node : MapNode) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let keys = (node.props.keys ctx).expression

        let values = (node.props.values ctx).expression

        let definition = "map[${keys}]${values}"

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderMap
