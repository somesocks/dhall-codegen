let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderDescription = ./render-description.dhall

let renderNumber
    : s.number.node.Type -> RenderFragment
    = \(node : s.number.node.Type) ->
      \(ctx : RenderContext) ->
        let description =
              (renderDescription node.meta.description ctx).expression

        let number =
              merge
                { none = "float64"
                , natural = "int"
                , integer = "int"
                , decimal = "float64"
                }
                node.props.variant

        let definition = number

        let expression = description ++ definition

        in  { expression, name = node.meta.name }

in  renderNumber
