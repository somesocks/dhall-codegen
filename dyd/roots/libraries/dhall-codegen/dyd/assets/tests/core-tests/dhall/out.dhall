
let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

let AnyTest0 =
  Any

let AnyTest1 =
  Any

let AnyTest2 =
  {- comment -}
  Any

let AnyTest3 =
  {- multi-line comment -}
  Any

let BooleanTest0 =
  Bool

let BooleanTest1 =
  {- comment -}
  Bool

let BooleanTest2 =
  {- multi-line comment -}
  Bool

let NumberTest0 =
  Double

let NumberTest1 =
  {- number -}
  Double

let NumberTest2 =
  {- natural -}
  Natural

let NumberTest3 =
  {- integer -}
  Integer

let NumberTest4 =
  {- decimal -}
  Double

let TextTest0 =
  Text

let TextTest1 =
  {- text -}
  Text

let TextTest2 =
  {- email -}
  Text

let TextTest3 =
  {- url -}
  Text

let TextTest4 =
  {- text literal -}
  Text

let TimeTest0 =
  Time

let TimeTest1 =
  {- comment -}
  Time

let Person =
  {
    age :
      Natural,
    deceased :
      Bool,
    name :
      Text
  }

let People =
  (
    List
      Person
  )

let OptionalTest0 =
  (
    Optional
      Text
  )

let OptionalTest1Value =
  {
    foo :
      Text
  }

let OptionalTest1 =
  (
    Optional
      OptionalTest1Value
  )

let OptionalTest2 =
  (
    Optional
      Text
  )

let ListTest0 =
  (
    {- a list -}
    List
      Text
  )

let ListTest1 =
  (
    {- a list -}
    List
      (
        {- a list inside a list -}
        List
          Text
      )
  )

let ListTest2Values =
  {
    {- a record inside a list -}
    foo :
      Text
  }

let ListTest2 =
  (
    {- a list -}
    List
      ListTest2Values
  )

let SetTest0 =
  (
    {- a set -}
    List
      Text
  )

let SetTest1 =
  (
    {- a set-like list -}
    List
      Text
  )

let SetTest2 =
  (
    {- a set -}
    List
      (
        {- a set inside a set -}
        List
          Text
      )
  )

let SetTest3Values =
  {
    {- a record inside a set -}
    foo :
      Text
  }

let SetTest3 =
  (
    {- a set -}
    List
      SetTest3Values
  )

let MapTest0 =
  (
  {- a map -}
    List
      {
        mapKey :
          Text
        , mapValue :
          Text
      }
  )

let MapTest1 =
  (
  {- a map-like record -}
    List
      {
        mapKey :
          Text
        , mapValue :
          Text
      }
  )

let MapTest2 =
  (
  {- a map -}
    List
      {
        mapKey :
          Text
        , mapValue :
          (
          {- a map inside a map -}
            List
              {
                mapKey :
                  Text
                , mapValue :
                  Text
              }
          )
      }
  )

let MapTest3Keys =
  {
    {- a keys record inside a map -}
    foo :
      Text
  }

let MapTest3Values =
  {
    {- a values record inside a map -}
    foo :
      Text
  }

let MapTest3 =
  (
  {- a map -}
    List
      {
        mapKey :
          MapTest3Keys
        , mapValue :
          MapTest3Values
      }
  )

let OneOfTest0 =
  <
    TextValue :
      Text |
    NaturalValue :
      Natural
  >

let OneOfTest1 =
    {- number or string -}
  <
    TextValue :
      Text |
    NaturalValue :
      Natural
  >

let OneOfTest2Option2 =
  {
    bar :
      Double,
    foo :
      Text
  }

let OneOfTest2 =
    {- number or string or record -}
  <
    TextValue :
      Text |
    NaturalValue :
      Natural |
    Details :
      OneOfTest2Option2
  >

let OneOfTest3 =
    {- named references -}
  <
    FooRef :
      Foo |
    BarRef :
      Bar
  >

let AllOfTest0Option0 =
  {
    bar :
      Double
  }

let AllOfTest0Option1 =
  {
    foo :
      Text
  }

let AllOfTest0 =
    {- all of two records -}
  (
      AllOfTest0Option0 //\\
      AllOfTest0Option1
  )

let TupleTest0 =
  {
    _1 :
      Text,
    _2 :
      Natural
  }

let TupleTest1 =
  {
    {- a tuple -}
    _1 :
      Text,
    _2 :
      Natural
  }

let TupleTest2 =
  {
    {- a tuple -}
    _1 :
      Text,
    _2 :
      {
        {- a tuple in a tuple -}
        _1 :
          Text,
        _2 :
          Natural
      }
  }

let RecordTest0 =
  {
    age :
      Natural,
    deceased :
      Bool,
    name :
      Text
  }

let RecordTest1 =
  {
    {- a record -}
    age :
      Natural,
    deceased :
      Bool,
    name :
      Text
  }

let RecordTest2Contact =
  {
    email : Optional 
      Text,
    phone : Optional 
      Text
  }

let RecordTest2 =
  {
    {- a record with an embedded record -}
    age :
      Natural,
    contact :
      RecordTest2Contact,
    deceased :
      Bool,
    name :
      Text
  }

let RecordTest3 =
  {
    {- a record with optional props -}
    name :
      Text,
    age : Optional 
      Natural,
    deceased : Optional 
      Bool
  }

let RecordTest4 =
  {
    id :
      Text,
    status :
      Text,
    age : Optional 
      Natural
  }

let FunctionTest0 =
  {} ->
  {}

let FunctionTest1 =
  {} ->
  {}

let FunctionTest2 =
  Bool ->
  {}

let FunctionTest3 =
  Bool ->
  {}

let FunctionTest4 =
  Bool ->
  Double ->
  Text ->
  {}

let FunctionTest5 =
  Bool ->
  Double ->
  Text ->
  {}

let FunctionTest6 =
  {} ->
  {}

let FunctionTest7 =
  {} ->
  {}

let FunctionTest8 =
  {} ->
  Bool

let FunctionTest9 =
  {} ->
  Bool

let FunctionTest10 =
  {} ->
  {
    _1 :
      Bool,
    _2 :
      Double,
    _3 :
      Text
  }

let FunctionTest11 =
  {} ->
  {
    _1 :
      Bool,
    _2 :
      Double,
    _3 :
      Text
  }

let FunctionTest12 =
  Natural ->
  Text ->
  {
    _1 :
      Text,
    _2 :
      Bool
  }

let FunctionTest13 =
  Natural ->
  Text ->
  {
    _1 :
      Text,
    _2 :
      Bool
  }

let FunctionTest14Input =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest14Output =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest14 =
  FunctionTest14Input ->
  FunctionTest14Output

let FunctionTest15Input0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15Input1 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15Output0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15Output1 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15 =
  FunctionTest15Input0 ->
  FunctionTest15Input1 ->
  {
    _1 :
      FunctionTest15Output0,
    _2 :
      FunctionTest15Output1
  }

in {
  AnyTest0,
  AnyTest1,
  AnyTest2,
  AnyTest3,
  BooleanTest0,
  BooleanTest1,
  BooleanTest2,
  NumberTest0,
  NumberTest1,
  NumberTest2,
  NumberTest3,
  NumberTest4,
  TextTest0,
  TextTest1,
  TextTest2,
  TextTest3,
  TextTest4,
  TimeTest0,
  TimeTest1,
  Person,
  People,
  OptionalTest0,
  OptionalTest1Value,
  OptionalTest1,
  OptionalTest2,
  ListTest0,
  ListTest1,
  ListTest2Values,
  ListTest2,
  SetTest0,
  SetTest1,
  SetTest2,
  SetTest3Values,
  SetTest3,
  MapTest0,
  MapTest1,
  MapTest2,
  MapTest3Keys,
  MapTest3Values,
  MapTest3,
  OneOfTest0,
  OneOfTest1,
  OneOfTest2Option2,
  OneOfTest2,
  OneOfTest3,
  AllOfTest0Option0,
  AllOfTest0Option1,
  AllOfTest0,
  TupleTest0,
  TupleTest1,
  TupleTest2,
  RecordTest0,
  RecordTest1,
  RecordTest2Contact,
  RecordTest2,
  RecordTest3,
  RecordTest4,
  FunctionTest0,
  FunctionTest1,
  FunctionTest2,
  FunctionTest3,
  FunctionTest4,
  FunctionTest5,
  FunctionTest6,
  FunctionTest7,
  FunctionTest8,
  FunctionTest9,
  FunctionTest10,
  FunctionTest11,
  FunctionTest12,
  FunctionTest13,
  FunctionTest14Input,
  FunctionTest14Output,
  FunctionTest14,
  FunctionTest15Input0,
  FunctionTest15Input1,
  FunctionTest15Output0,
  FunctionTest15Output1,
  FunctionTest15
}