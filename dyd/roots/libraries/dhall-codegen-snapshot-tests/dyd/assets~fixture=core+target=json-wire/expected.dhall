
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

let TextTest5 =
  {- RFC 3339 date-time -}
  Text

let TextTest6 =
  {- ISO 8601 calendar date -}
  Text

let TextTest7 =
  {- ISO 8601 local time -}
  Text

let TextTest8 =
  {- ISO 8601 duration -}
  Text

let TextTest9 =
  {- RFC 4122 UUID -}
  Text

let TextTest10 =
  {- IPv4 address -}
  Text

let TextTest11 =
  {- IPv6 address -}
  Text

let TextTest12 =
  {- RFC 4648 Base64 -}
  Text

let TextTest13 =
  {- RFC 4648 Base64url -}
  Text

let TextTest14 =
  {- E.164 telephone number -}
  Text

let TimeTest0 =
  Text

let TimeTest1 =
  {- comment -}
  Text

let TimeTest2 =
  {- calendar date -}
  Text

let TimeTest3 =
  {- local time -}
  Text

let TimeTest4 =
  {- ISO 8601 duration -}
  Text

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

let MapTest0Values =
  {
    key :
      Text,
    value :
      Text
  }

let MapTest0 =
  (
    {- a map -}
    List
      MapTest0Values
  )

let MapTest1Values =
  {
    key :
      Text,
    value :
      Text
  }

let MapTest1 =
  (
    {- a map-like record -}
    List
      MapTest1Values
  )

let MapTest2ValuesValueValues =
  {
    key :
      Text,
    value :
      Text
  }

let MapTest2Values =
  {
    key :
      Text,
    value :
      (
        {- a map inside a map -}
        List
          MapTest2ValuesValueValues
      )
  }

let MapTest2 =
  (
    {- a map -}
    List
      MapTest2Values
  )

let MapTest3ValuesKey =
  {
    {- a keys record inside a map -}
    foo :
      Text
  }

let MapTest3ValuesValue =
  {
    {- a values record inside a map -}
    foo :
      Text
  }

let MapTest3Values =
  {
    key :
      MapTest3ValuesKey,
    value :
      MapTest3ValuesValue
  }

let MapTest3 =
  (
    {- a map -}
    List
      MapTest3Values
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

let OneOfTest4Option0 =
  {
    bar :
      Double,
    foo :
      Text
  }

let OneOfTest4Option1 =
  {
    foo :
      Text
  }

let OneOfTest4 =
    {- extended record before base record -}
  <
    ExtendedRecord :
      OneOfTest4Option0 |
    BaseRecord :
      OneOfTest4Option1
  >

let OneOfTest5Option0 =
  {
    foo :
      Text
  }

let OneOfTest5Option1 =
  {
    bar :
      Double,
    foo :
      Text
  }

let OneOfTest5 =
    {- base record before extended record -}
  <
    BaseRecord :
      OneOfTest5Option0 |
    ExtendedRecord :
      OneOfTest5Option1
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

let RecordTest5HeadersValues =
  {
    key :
      Text,
    value :
      Text
  }

let RecordTest5 =
  {
    {- a record with a record map -}
    headers :
      (
        List
          RecordTest5HeadersValues
      )
  }

let FunctionTest0 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest1 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest2 =
  {
    input :
      {
        _1 :
          Bool
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest3 =
  {
    input :
      {
        _1 :
          Bool
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest4 =
  {
    input :
      {
        _1 :
          Bool,
        _2 :
          Double,
        _3 :
          Text
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest5 =
  {
    input :
      {
        _1 :
          Bool,
        _2 :
          Double,
        _3 :
          Text
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest6 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest7 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
      }
  }

let FunctionTest8 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
        _1 :
          Bool
      }
  }

let FunctionTest9 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
        _1 :
          Bool
      }
  }

let FunctionTest10 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
        _1 :
          Bool,
        _2 :
          Double,
        _3 :
          Text
      }
  }

let FunctionTest11 =
  {
    input :
      {
      },
    kind :
      Text,
    output :
      {
        _1 :
          Bool,
        _2 :
          Double,
        _3 :
          Text
      }
  }

let FunctionTest12 =
  {
    input :
      {
        _1 :
          Natural,
        _2 :
          Text
      },
    kind :
      Text,
    output :
      {
        _1 :
          Text,
        _2 :
          Bool
      }
  }

let FunctionTest13 =
  {
    input :
      {
        _1 :
          Natural,
        _2 :
          Text
      },
    kind :
      Text,
    output :
      {
        _1 :
          Text,
        _2 :
          Bool
      }
  }

let FunctionTest14InputValue0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest14OutputValue0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest14 =
  {
    input :
      {
        _1 :
          FunctionTest14InputValue0
      },
    kind :
      Text,
    output :
      {
        _1 :
          FunctionTest14OutputValue0
      }
  }

let FunctionTest15InputValue0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15InputValue1 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15OutputValue0 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15OutputValue1 =
  {
    bar :
      Text,
    foo :
      Natural
  }

let FunctionTest15 =
  {
    input :
      {
        _1 :
          FunctionTest15InputValue0,
        _2 :
          FunctionTest15InputValue1
      },
    kind :
      Text,
    output :
      {
        _1 :
          FunctionTest15OutputValue0,
        _2 :
          FunctionTest15OutputValue1
      }
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
  TextTest5,
  TextTest6,
  TextTest7,
  TextTest8,
  TextTest9,
  TextTest10,
  TextTest11,
  TextTest12,
  TextTest13,
  TextTest14,
  TimeTest0,
  TimeTest1,
  TimeTest2,
  TimeTest3,
  TimeTest4,
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
  MapTest0Values,
  MapTest0,
  MapTest1Values,
  MapTest1,
  MapTest2ValuesValueValues,
  MapTest2Values,
  MapTest2,
  MapTest3ValuesKey,
  MapTest3ValuesValue,
  MapTest3Values,
  MapTest3,
  OneOfTest0,
  OneOfTest1,
  OneOfTest2Option2,
  OneOfTest2,
  OneOfTest3,
  OneOfTest4Option0,
  OneOfTest4Option1,
  OneOfTest4,
  OneOfTest5Option0,
  OneOfTest5Option1,
  OneOfTest5,
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
  RecordTest5HeadersValues,
  RecordTest5,
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
  FunctionTest14InputValue0,
  FunctionTest14OutputValue0,
  FunctionTest14,
  FunctionTest15InputValue0,
  FunctionTest15InputValue1,
  FunctionTest15OutputValue0,
  FunctionTest15OutputValue1,
  FunctionTest15
}