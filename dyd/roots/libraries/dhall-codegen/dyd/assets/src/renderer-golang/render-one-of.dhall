let List/mapWithIndex = ../prelude/List/mapWithIndex.dhall

let Text/concat = ../prelude/Text/concat.dhall

let Text/concatSep = ../prelude/Text/concatSep.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderDescription = ./render-description.dhall

let Text/snakeCase = ../utils/Text/snakeCase.dhall

let OneOfNode = (Schema.oneOf.nodeF RenderFragment).Type

let renderOptionField
    : RenderContext -> Natural -> RenderFragment -> Text
    = \(ctx : RenderContext) ->
      \(index : Natural) ->
      \(opt : RenderFragment) ->
        let value = opt ctx

        let name =
              merge
                { None = "Option${Natural/show (index + 1)}"
                , Some = \(n : Text) -> n
                }
                value.name

        let tag =
              merge
                { None = "option${Natural/show (index + 1)}"
                , Some = \(n : Text) -> n
                }
                value.name

        let tag = "`json:\"${tag},omitempty\"`"

        let fieldName = Text/snakeCase name

        let expression =
              renderPrefix ctx
              ++  fieldName
              ++  " "
              ++  "*"
              ++  value.expression
              ++  " "
              ++  tag

        in  expression

let renderOneOf
    : OneOfNode -> RenderFragment
    = \(x : OneOfNode) ->
      \(ctx : RenderContext) ->
        let description = (renderDescription x.meta.description ctx).expression

        let ctx2 = ctx // { depth = ctx.depth + 1 }

        let header = "struct {"

        let kindType =
              merge
                { None = "string"
                , Some = \(name : Text) -> ctx.options.prefix ++ name ++ "Kind"
                }
                ctx.oneOfName

        let kindField =
              renderPrefix ctx2 ++ "Kind ${kindType} `json:\"kind\"`"

        let optionFields =
              List/mapWithIndex
                RenderFragment
                Text
                (renderOptionField ctx2)
                x.props.options

        let body = Text/concat ([ kindField ] # optionFields)

        let footer = renderPrefix ctx ++ "}"

        let structDef = header ++ body ++ footer

        let kindDecl =
              merge
                { None = ""
                , Some =
                    \(name : Text) ->
                      let typeName = ctx.options.prefix ++ name

                      let kindName = "${typeName}Kind"

                      let renderConst =
                            \(index : Natural) ->
                            \(opt : RenderFragment) ->
                              let n = index + 1

                              let value = opt ctx

                              let baseName =
                                    merge
                                      { None = "Option${Natural/show n}"
                                      , Some = \(t : Text) -> t
                                      }
                                      value.name

                              let valueName =
                                    merge
                                      { None = "option${Natural/show n}"
                                      , Some = \(t : Text) -> t
                                      }
                                      value.name

                              let ident = Text/snakeCase baseName

                              in  "\t${kindName}${ident} ${kindName} = \"${valueName}\""

                      let consts =
                            Text/concatSep
                              "\n"
                              ( List/mapWithIndex
                                  RenderFragment
                                  Text
                                  renderConst
                                  x.props.options
                              )

                      in  ''
                          type ${kindName} string

                          const (
                          ${consts}
                          )

                          ''
                }
                ctx.oneOfName
        let definition =
              merge
                { None = structDef
                , Some =
                    \(name : Text) ->
                      "type ${ctx.options.prefix}${name} ${structDef}"
                }
                ctx.oneOfName

        let expression = kindDecl ++ description ++ definition

        in  { expression, name = x.meta.name }

in  renderOneOf
