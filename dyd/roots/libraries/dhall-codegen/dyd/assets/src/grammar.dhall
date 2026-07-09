let List/map = ./prelude/List/map.dhall

let Fix
    : (Type -> Type) -> Type
    = \(F : Type -> Type) -> forall (A : Type) -> (F A -> A) -> A

let fold =
      \(F : Type -> Type) ->
      \(A : Type) ->
      \(alg : F A -> A) ->
      \(fx : Fix F) ->
        fx A alg

let inn =
      \(F : Type -> Type) ->
      \ ( Fmap
        : forall (A : Type) -> forall (B : Type) -> (A -> B) -> F A -> F B
        ) ->
      \(x : F (Fix F)) ->
      \(A : Type) ->
      \(alg : F A -> A) ->
        alg (Fmap (Fix F) A (fold F A alg) x)

let commonMeta =
      { Type = { description : Optional Text, sensitive : Bool }
      , default = { description = None Text, sensitive = False }
      }

let nodeMeta =
      { Type = commonMeta.Type //\\ { name : Optional Text }
      , default = commonMeta.default // { name = None Text }
      }

let rootMeta =
      { Type = commonMeta.Type //\\ { name : Text }
      , default = commonMeta.default
      }

let anyVariants = < none | permissive >

let anyProps =
      { Type = { variant : anyVariants }, default.variant = anyVariants.none }

let anyMeta = nodeMeta

let anyNode =
      { Type = { props : anyProps.Type, meta : anyMeta.Type }, default = {=} }

let booleanProps = { Type = {}, default = {=} }

let booleanMeta = nodeMeta

let booleanNode =
      { Type = { props : booleanProps.Type, meta : booleanMeta.Type }
      , default = {=}
      }

let numberVariants = < none | natural | integer | decimal >

let numberProps =
      { Type = { variant : numberVariants }
      , default.variant = numberVariants.none
      }

let numberMeta = nodeMeta

let numberNode =
      { Type = { props : numberProps.Type, meta : numberMeta.Type }
      , default = {=}
      }

let textVariants = < none | email | url | literal : Text >

let textProps =
      { Type = { variant : textVariants }, default.variant = textVariants.none }

let textMeta = nodeMeta

let textNode =
      { Type = { props : textProps.Type, meta : textMeta.Type }, default = {=} }

let timeVariants = < none >

let timeProps =
      { Type = { variant : timeVariants }, default.variant = timeVariants.none }

let timeMeta = nodeMeta

let timeNode =
      { Type = { props : timeProps.Type, meta : timeMeta.Type }, default = {=} }

let referenceProps = { Type = { to : Text }, default = {=} }

let referenceMeta = nodeMeta

let referenceNode =
      { Type = { props : referenceProps.Type, meta : referenceMeta.Type }
      , default = {=}
      }

let optionalVariants = < none | nullable >

let optionalProps = \(a : Type) -> { Type = { value : a }, default = {=} }

let optionalMeta = nodeMeta

let optionalNode =
      \(a : Type) ->
        { Type = { props : (optionalProps a).Type, meta : optionalMeta.Type }
        , default = {=}
        }

let listProps = \(a : Type) -> { Type = { values : a }, default = {=} }

let listMeta = nodeMeta

let listNode =
      \(a : Type) ->
        { Type = { props : (listProps a).Type, meta : listMeta.Type }
        , default = {=}
        }

let setVariants = < none | list >

let setProps =
      \(a : Type) ->
        { Type = { values : a, variant : setVariants }
        , default.variant = setVariants.none
        }

let setMeta = nodeMeta

let setNode =
      \(a : Type) ->
        { Type = { props : (setProps a).Type, meta : setMeta.Type }
        , default = {=}
        }

let mapVariants = < none | record >

let mapProps =
      \(a : Type) ->
        { Type = { keys : a, values : a, variant : mapVariants }
        , default.variant = mapVariants.none
        }

let mapMeta = nodeMeta

let mapNode =
      \(a : Type) ->
        { Type = { props : (mapProps a).Type, meta : mapMeta.Type }
        , default = {=}
        }

let oneOfProps = \(a : Type) -> { Type = { options : List a }, default = {=} }

let oneOfMeta = nodeMeta

let oneOfNode =
      \(a : Type) ->
        { Type = { props : (oneOfProps a).Type, meta : oneOfMeta.Type }
        , default = {=}
        }

let allOfProps = \(a : Type) -> { Type = { options : List a }, default = {=} }

let allOfMeta = nodeMeta

let allOfNode =
      \(a : Type) ->
        { Type = { props : (allOfProps a).Type, meta : allOfMeta.Type }
        , default = {=}
        }

let tupleProps = \(a : Type) -> { Type = { values : List a }, default = {=} }

let tupleMeta = nodeMeta

let tupleNode =
      \(a : Type) ->
        { Type = { props : (tupleProps a).Type, meta : tupleMeta.Type }
        , default = {=}
        }

let recordVariants = < none | interface >

let recordProps =
      \(a : Type) ->
        { Type =
            { required : List { mapKey : Text, mapValue : a }
            , optional : List { mapKey : Text, mapValue : a }
            , variant : recordVariants
            }
        , default =
          { required = [] : List { mapKey : Text, mapValue : a }
          , optional = [] : List { mapKey : Text, mapValue : a }
          , variant = recordVariants.none
          }
        }

let recordMeta = nodeMeta

let recordNode =
      \(a : Type) ->
        { Type = { props : (recordProps a).Type, meta : recordMeta.Type }
        , default = {=}
        }

let functionVariants = < none | async >

let functionProps =
      \(a : Type) ->
        { Type = { input : List a, output : List a, variant : functionVariants }
        , default =
          { input = [] : List a
          , output = [] : List a
          , variant = functionVariants.none
          }
        }

let functionMeta = nodeMeta

let functionNode =
      \(a : Type) ->
        { Type = { props : (functionProps a).Type, meta : functionMeta.Type }
        , default = {=}
        }

let SchemaF
    : Type -> Type
    = \(a : Type) ->
        < Any : anyNode.Type
        | Boolean : booleanNode.Type
        | Number : numberNode.Type
        | Text : textNode.Type
        | Time : timeNode.Type
        | Reference : referenceNode.Type
        | Optional : (optionalNode a).Type
        | List : (listNode a).Type
        | Set : (setNode a).Type
        | Map : (mapNode a).Type
        | OneOf : (oneOfNode a).Type
        | AllOf : (allOfNode a).Type
        | Tuple : (tupleNode a).Type
        | Record : (recordNode a).Type
        | Function : (functionNode a).Type
        >

let fmap-SchemaF
    : forall (A : Type) ->
      forall (B : Type) ->
      (A -> B) ->
      SchemaF A ->
        SchemaF B
    = \(A : Type) ->
      \(B : Type) ->
      \(f : A -> B) ->
      \(layer : SchemaF A) ->
        let U = SchemaF B

        in  merge
              { Any = \(x : anyNode.Type) -> U.Any x
              , Boolean = \(x : booleanNode.Type) -> U.Boolean x
              , Number = \(x : numberNode.Type) -> U.Number x
              , Text = \(x : textNode.Type) -> U.Text x
              , Time = \(x : timeNode.Type) -> U.Time x
              , Reference = \(x : referenceNode.Type) -> U.Reference x
              , Optional =
                  \(x : (optionalNode A).Type) ->
                    U.Optional { meta = x.meta, props.value = f x.props.value }
              , List =
                  \(x : (listNode A).Type) ->
                    U.List { meta = x.meta, props.values = f x.props.values }
              , Set =
                  \(x : (setNode A).Type) ->
                    U.Set
                      { meta = x.meta
                      , props.values = f x.props.values
                      , props.variant = x.props.variant
                      }
              , Map =
                  \(x : (mapNode A).Type) ->
                    U.Map
                      { meta = x.meta
                      , props.keys = f x.props.keys
                      , props.values = f x.props.values
                      , props.variant = x.props.variant
                      }
              , OneOf =
                  \(x : (oneOfNode A).Type) ->
                    U.OneOf
                      { meta = x.meta
                      , props.options = List/map A B f x.props.options
                      }
              , AllOf =
                  \(x : (allOfNode A).Type) ->
                    U.AllOf
                      { meta = x.meta
                      , props.options = List/map A B f x.props.options
                      }
              , Tuple =
                  \(x : (tupleNode A).Type) ->
                    U.Tuple
                      { meta = x.meta
                      , props.values = List/map A B f x.props.values
                      }
              , Record =
                  \(x : (recordNode A).Type) ->
                    let mappedRequiredFields =
                          List/map
                            { mapKey : Text, mapValue : A }
                            { mapKey : Text, mapValue : B }
                            ( \(field : { mapKey : Text, mapValue : A }) ->
                                { mapKey = field.mapKey
                                , mapValue = f field.mapValue
                                }
                            )
                            x.props.required

                    let mappedOptionalFields =
                          List/map
                            { mapKey : Text, mapValue : A }
                            { mapKey : Text, mapValue : B }
                            ( \(field : { mapKey : Text, mapValue : A }) ->
                                { mapKey = field.mapKey
                                , mapValue = f field.mapValue
                                }
                            )
                            x.props.optional

                    in  U.Record
                          { meta = x.meta
                          , props.required = mappedRequiredFields
                          , props.optional = mappedOptionalFields
                          , props.variant = x.props.variant
                          }
              , Function =
                  \(x : (functionNode A).Type) ->
                    U.Function
                      { meta = x.meta
                      , props.input = List/map A B f x.props.input
                      , props.output = List/map A B f x.props.output
                      , props.variant = x.props.variant
                      }
              }
              layer

let Schema
    : Type
    = Fix SchemaF

let SchemaUnion = SchemaF Schema

let injSchema
    : SchemaUnion -> Schema
    = inn SchemaF fmap-SchemaF

let anyFrom
    : anyProps.Type -> anyMeta.Type -> Schema
    = \(props : anyProps.Type) ->
      \(meta : anyMeta.Type) ->
        injSchema (SchemaUnion.Any { props, meta })

let booleanFrom
    : booleanProps.Type -> booleanMeta.Type -> Schema
    = \(props : booleanProps.Type) ->
      \(meta : booleanMeta.Type) ->
        injSchema (SchemaUnion.Boolean { props, meta })

let numberFrom
    : numberProps.Type -> numberMeta.Type -> Schema
    = \(props : numberProps.Type) ->
      \(meta : numberMeta.Type) ->
        injSchema (SchemaUnion.Number { props, meta })

let textFrom
    : textProps.Type -> textMeta.Type -> Schema
    = \(props : textProps.Type) ->
      \(meta : textMeta.Type) ->
        injSchema (SchemaUnion.Text { props, meta })

let timeFrom
    : timeProps.Type -> timeMeta.Type -> Schema
    = \(props : timeProps.Type) ->
      \(meta : timeMeta.Type) ->
        injSchema (SchemaUnion.Time { props, meta })

let referenceFrom
    : referenceProps.Type -> referenceMeta.Type -> Schema
    = \(props : referenceProps.Type) ->
      \(meta : referenceMeta.Type) ->
        injSchema (SchemaUnion.Reference { meta, props })

let optionalFrom
    : (optionalProps Schema).Type -> optionalMeta.Type -> Schema
    = \(props : (optionalProps Schema).Type) ->
      \(meta : optionalMeta.Type) ->
        injSchema (SchemaUnion.Optional { meta, props })

let listFrom
    : (listProps Schema).Type -> listMeta.Type -> Schema
    = \(props : (listProps Schema).Type) ->
      \(meta : listMeta.Type) ->
        injSchema (SchemaUnion.List { meta, props })

let setFrom
    : (setProps Schema).Type -> setMeta.Type -> Schema
    = \(props : (setProps Schema).Type) ->
      \(meta : setMeta.Type) ->
        injSchema (SchemaUnion.Set { meta, props })

let mapFrom
    : (mapProps Schema).Type -> mapMeta.Type -> Schema
    = \(props : (mapProps Schema).Type) ->
      \(meta : mapMeta.Type) ->
        injSchema (SchemaUnion.Map { meta, props })

let oneOfFrom
    : (oneOfProps Schema).Type -> oneOfMeta.Type -> Schema
    = \(props : (oneOfProps Schema).Type) ->
      \(meta : oneOfMeta.Type) ->
        injSchema (SchemaUnion.OneOf { meta, props })

let allOfFrom
    : (allOfProps Schema).Type -> allOfMeta.Type -> Schema
    = \(props : (allOfProps Schema).Type) ->
      \(meta : allOfMeta.Type) ->
        injSchema (SchemaUnion.AllOf { meta, props })

let tupleFrom
    : (tupleProps Schema).Type -> tupleMeta.Type -> Schema
    = \(props : (tupleProps Schema).Type) ->
      \(meta : tupleMeta.Type) ->
        injSchema (SchemaUnion.Tuple { meta, props })

let recordFrom
    : (recordProps Schema).Type -> recordMeta.Type -> Schema
    = \(props : (recordProps Schema).Type) ->
      \(meta : recordMeta.Type) ->
        injSchema (SchemaUnion.Record { meta, props })

let functionFrom
    : (functionProps Schema).Type -> functionMeta.Type -> Schema
    = \(props : (functionProps Schema).Type) ->
      \(meta : functionMeta.Type) ->
        injSchema (SchemaUnion.Function { meta, props })

let RootSchema = { meta : rootMeta.Type, contains : Schema }

let rootFrom
    : Schema -> rootMeta.Type -> RootSchema
    = \(contains : Schema) -> \(meta : rootMeta.Type) -> { meta, contains }

let Document =
      { Type =
          { headers : List Text
          , schemas : List RootSchema
          , description : Optional Text
          }
      , default =
        { headers = [] : List Text
        , schemas = [] : List RootSchema
        , description = None Text
        }
      }

let Renderer
    : Type
    = Document.Type -> Text

let Transformer
    : Type
    = Document.Type -> Document.Type

in  { Schema =
      { type = Schema
      , typeF = SchemaF
      , any =
        { from = anyFrom
        , props = anyProps
        , meta = anyMeta
        , node = anyNode
        , variants = anyVariants
        }
      , boolean =
        { from = booleanFrom
        , props = booleanProps
        , meta = booleanMeta
        , node = booleanNode
        }
      , number =
        { from = numberFrom
        , props = numberProps
        , meta = numberMeta
        , variants = numberVariants
        , node = numberNode
        }
      , text =
        { from = textFrom
        , meta = textMeta
        , variants = textVariants
        , props = textProps
        , node = textNode
        }
      , time =
        { from = timeFrom
        , meta = timeMeta
        , variants = timeVariants
        , props = timeProps
        , node = timeNode
        }
      , reference =
        { from = referenceFrom
        , props = referenceProps
        , meta = referenceMeta
        , node = referenceNode
        }
      , optional =
        { from = optionalFrom
        , meta = optionalMeta
        , props = optionalProps Schema
        , propsF = optionalProps
        , node = optionalNode Schema
        , nodeF = optionalNode
        }
      , list =
        { from = listFrom
        , meta = listMeta
        , props = listProps Schema
        , propsF = listProps
        , node = listNode Schema
        , nodeF = listNode
        }
      , set =
        { from = setFrom
        , meta = setMeta
        , variants = setVariants
        , props = setProps Schema
        , propsF = setProps
        , node = setNode Schema
        , nodeF = setNode
        }
      , map =
        { from = mapFrom
        , meta = mapMeta
        , variants = mapVariants
        , props = mapProps Schema
        , propsF = mapProps
        , node = mapNode Schema
        , nodeF = mapNode
        }
      , oneOf =
        { from = oneOfFrom
        , meta = oneOfMeta
        , props = oneOfProps Schema
        , propsF = oneOfProps
        , node = oneOfNode Schema
        , nodeF = oneOfNode
        }
      , allOf =
        { from = allOfFrom
        , meta = allOfMeta
        , props = allOfProps Schema
        , propsF = allOfProps
        , node = allOfNode Schema
        , nodeF = allOfNode
        }
      , tuple =
        { from = tupleFrom
        , meta = tupleMeta
        , props = tupleProps Schema
        , propsF = tupleProps
        , node = tupleNode Schema
        , nodeF = tupleNode
        }
      , record =
        { from = recordFrom
        , meta = recordMeta
        , props = recordProps Schema
        , propsF = recordProps
        , node = recordNode Schema
        , nodeF = recordNode
        , variants = recordVariants
        }
      , function =
        { from = functionFrom
        , meta = functionMeta
        , props = functionProps Schema
        , propsF = functionProps
        , node = functionNode Schema
        , nodeF = functionNode
        , variants = functionVariants
        }
      , root = { type = RootSchema, from = rootFrom, meta = rootMeta }
      , fold
      }
    , Document
    , Renderer
    , Transformer
    }
