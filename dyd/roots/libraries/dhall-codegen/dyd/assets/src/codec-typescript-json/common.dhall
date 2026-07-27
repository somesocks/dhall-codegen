let typescript = ../renderer-typescript/common.dhall

let RenderOptions = typescript.RenderOptions

let TimeMode = typescript.TimeMode

let RenderContext = { options : RenderOptions, indentation : Text }

let RenderFragment : Type = RenderContext -> Text

in  { RenderOptions, TimeMode, RenderContext, RenderFragment }
