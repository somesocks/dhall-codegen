let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let common = ./common.dhall

let RenderContext = common.RenderContext

let RenderFragment = common.RenderFragment

let renderPrefix = ./render-prefix.dhall

let renderZodDescription = ./render-zod-description.dhall

let renderZod3TextVariant
    : s.text.variants -> Text
    = \(variant : s.text.variants) ->
        merge
          { none = "z.string()"
          , email = "z.string().email()"
          , url = "z.string().url()"
          , base64 = "z.string().regex(/^(?:[A-Za-z0-9+\\u002F]{4})*(?:[A-Za-z0-9+\\u002F]{2}(?:==)?|[A-Za-z0-9+\\u002F]{3}=?)?$/)"
          , base64url = "z.string().regex(/^(?:[A-Za-z0-9_-]{4})*(?:[A-Za-z0-9_-]{2}(?:==)?|[A-Za-z0-9_-]{3}=?)?$/)"
          , e164 = "z.string().regex(/^[+][1-9][0-9]{0,14}$/)"
          , ipv4 = "z.string().ip({ version: \"v4\" })"
          , ipv6 = "z.string().ip({ version: \"v6\" })"
          , isoDate = "z.string().date()"
          , isoDateTime = "z.string().datetime({ offset: true })"
          , isoDuration = "z.string().duration()"
          , isoTime = "z.string().regex(/^(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](?:[.][0-9]+)?(?:Z|[+-](?:[01][0-9]|2[0-3]):[0-5][0-9])$/)"
          , uuid = "z.string().uuid()"
          , literal = \(x : Text) -> "z.literal(\"${x}\")"
          }
          variant

let renderZod4TextVariant
    : s.text.variants -> Text
    = \(variant : s.text.variants) ->
        merge
          { none = "z.string()"
          , email = "z.email()"
          , url = "z.url()"
          , base64 = "z.string().regex(/^(?:[A-Za-z0-9+\\u002F]{4})*(?:[A-Za-z0-9+\\u002F]{2}(?:==)?|[A-Za-z0-9+\\u002F]{3}=?)?$/)"
          , base64url = "z.string().regex(/^(?:[A-Za-z0-9_-]{4})*(?:[A-Za-z0-9_-]{2}(?:==)?|[A-Za-z0-9_-]{3}=?)?$/)"
          , e164 = "z.string().regex(/^[+][1-9][0-9]{0,14}$/)"
          , ipv4 = "z.ipv4()"
          , ipv6 = "z.ipv6()"
          , isoDate = "z.iso.date()"
          , isoDateTime = "z.iso.datetime({ offset: true })"
          , isoDuration = "z.iso.duration()"
          , isoTime = "z.string().regex(/^(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](?:[.][0-9]+)?(?:Z|[+-](?:[01][0-9]|2[0-3]):[0-5][0-9])$/)"
          , uuid = "z.uuid()"
          , literal = \(x : Text) -> "z.literal(\"${x}\")"
          }
          variant

let renderText
    : s.text.node.Type -> RenderFragment
    = \(node : s.text.node.Type) ->
      \(ctx : RenderContext) ->
        let string =
              merge
                { ZOD_3 = renderZod3TextVariant node.props.variant
                , ZOD_3_RECURSION = renderZod3TextVariant node.props.variant
                , ZOD_4 = renderZod4TextVariant node.props.variant
                , ZOD_4_RECURSION = renderZod4TextVariant node.props.variant
                }
                ctx.options.variant

        let description = renderZodDescription node.meta.description

        let definition = renderPrefix ctx ++ string

        let expression = definition ++ description

        in  { expression }

in  renderText
