let golang = ../renderer-golang/common.dhall

let RenderOptions = golang.RenderOptions

let RenderContext =
      { options : RenderOptions
      , indentation : Text
      , rootType : Optional Text
      , label : Text
      , onError : Text
      }

in  { RenderOptions, RenderContext }
