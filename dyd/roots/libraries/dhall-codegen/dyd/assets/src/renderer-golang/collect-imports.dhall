let List_fold = ../prelude/List/fold.dhall

let Grammar = ../grammar.dhall

let Schema = Grammar.Schema

let s = Schema

let ImportInfo = { usesTime : Bool }

let empty : ImportInfo = { usesTime = False }

let mergeImports
    : ImportInfo -> ImportInfo -> ImportInfo
    = \(a : ImportInfo) ->
      \(b : ImportInfo) ->
        { usesTime = a.usesTime || b.usesTime }

let collectSchema
    : s.typeF ImportInfo -> ImportInfo
    = \(layer : s.typeF ImportInfo) ->
        let recurse =
              \(xs : List ImportInfo) ->
                List_fold ImportInfo xs ImportInfo mergeImports empty

        in  merge
              { Any = \(x : s.any.node.Type) -> empty
              , Boolean = \(x : s.boolean.node.Type) -> empty
              , Number = \(x : s.number.node.Type) -> empty
              , Text = \(x : s.text.node.Type) -> empty
              , Time = \(x : s.time.node.Type) -> { usesTime = True }
              , Reference = \(x : s.reference.node.Type) -> empty
              , Optional = \(x : (s.optional.nodeF ImportInfo).Type) -> x.props.value
              , List = \(x : (s.list.nodeF ImportInfo).Type) -> x.props.values
              , Set = \(x : (s.set.nodeF ImportInfo).Type) -> x.props.values
              , Map =
                  \(x : (s.map.nodeF ImportInfo).Type) ->
                    mergeImports x.props.keys x.props.values
              , OneOf =
                  \(x : (s.oneOf.nodeF ImportInfo).Type) ->
                    recurse x.props.options
              , AllOf =
                  \(x : (s.allOf.nodeF ImportInfo).Type) ->
                    recurse x.props.options
              , Tuple =
                  \(x : (s.tuple.nodeF ImportInfo).Type) ->
                    recurse x.props.values
              , Record =
                  \(x : (s.record.nodeF ImportInfo).Type) ->
                    let required =
                          List_fold
                            { mapKey : Text, mapValue : ImportInfo }
                            x.props.required
                            ImportInfo
                            ( \(field : { mapKey : Text, mapValue : ImportInfo }) ->
                              \(state : ImportInfo) ->
                                mergeImports state field.mapValue
                            )
                            empty

                    let optional =
                          List_fold
                            { mapKey : Text, mapValue : ImportInfo }
                            x.props.optional
                            ImportInfo
                            ( \(field : { mapKey : Text, mapValue : ImportInfo }) ->
                              \(state : ImportInfo) ->
                                mergeImports state field.mapValue
                            )
                            empty

                    in  mergeImports required optional
              , Function =
                  \(x : (s.function.nodeF ImportInfo).Type) ->
                    let input = recurse x.props.input

                    let output = recurse x.props.output

                    in  mergeImports input output
              }
              layer

let collect = s.fold s.typeF ImportInfo collectSchema

in  { ImportInfo, empty, mergeImports, collect }
