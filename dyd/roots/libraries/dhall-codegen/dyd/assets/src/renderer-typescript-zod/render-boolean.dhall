let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderBoolean
    : s.boolean.node.Type -> RenderFragment
    = \(node : s.boolean.node.Type) ->
      \(ctx : RenderContext) ->
        let description = renderZodDescription node.meta.description

        let definition = renderPrefix ctx ++ "z.boolean()"

        let expression = definition ++ description

        in  { expression }

in  renderBoolean
