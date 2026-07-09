let List/unpackOptionals = ../prelude/List/unpackOptionals.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription2 = ./render-description-2.dhall

let FunctionNode = (Schema.function.nodeF RenderFragment).Type

let renderFunction
    : FunctionNode → RenderFragment
    = λ(node : FunctionNode) →
      λ(ctx : RenderContext) →
        let definition =
              "{ \"error\" : \"functions are not supported in json-schema. this should have been transformed at an earlier stage in the renderer\" }"

        let expression = definition

        in  { expression }

in  renderFunction
