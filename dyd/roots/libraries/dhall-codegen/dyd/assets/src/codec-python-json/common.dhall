let python = ../renderer-python-3.11/package.dhall

let RenderContext = { indent : Text, label : Text }

let Fragment : Type =
      { encode : RenderContext -> Text -> Text -> Text -> Text
      , decode : RenderContext -> Text -> Text -> Text -> Text
      , pythonType : RenderContext -> Text
      , interfaceImplementation : Text -> Text
      , rootDecode : Text -> Text
      }

in  { python, RenderContext, Fragment }
