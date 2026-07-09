let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderNumber
    : s.number.node.Type -> RenderFragment
    = \(node : s.number.node.Type) ->
      \(ctx : RenderContext) ->
        let number =
              merge
                { none = "z.number()"
                , natural = "z.number().int().nonnegative()"
                , integer = "z.number().int()"
                , decimal = "z.number()"
                }
                node.props.variant

        let description = renderZodDescription node.meta.description

        let definition = renderPrefix ctx ++ number

        let expression = definition ++ description

        in  { expression }

in  renderNumber
