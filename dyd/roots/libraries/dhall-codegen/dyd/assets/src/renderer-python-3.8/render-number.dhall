let Grammar = ../grammar.dhall

let s = Grammar.Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let ExpressionType = common.ExpressionType

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let renderNumber
    : s.number.node.Type -> RenderFragment
    = \(node : s.number.node.Type) ->
      \(ctx : RenderContext) ->
        let number =
              merge
                { none = "float"
                , natural = "int"
                , integer = "int"
                , decimal = "float"
                }
                node.props.variant

        let description = ""

        let definition = number

        let expression = description ++ definition

        in  { expression, type = ExpressionType.TypeAlias }

in  renderNumber
