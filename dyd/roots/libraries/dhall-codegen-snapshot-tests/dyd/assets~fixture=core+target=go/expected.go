package models

import "time"

// any test 0
type AnyTest0 interface{}

// any test 1
type AnyTest1 interface{}

// any test 2
type AnyTest2 interface{}

// any test 3
type AnyTest3 interface{}

// boolean test 0
type BooleanTest0 bool

// boolean test 1
type BooleanTest1 bool

// boolean test 2
type BooleanTest2 bool

// number test 0
type NumberTest0 float64

// number test 1
type NumberTest1 float64

// number test 2
type NumberTest2 int

// number test 3
type NumberTest3 int

// number test 4
type NumberTest4 float64

// text test 0
type TextTest0 string

// text test 1
type TextTest1 string

// text test 2
type TextTest2 string

// text test 3
type TextTest3 string

// text test 4
type TextTest4 string

// time test 0
type TimeTest0 time.Time

// time test 1
type TimeTest1 time.Time

type Person struct {
	Age int `json:"age"`
	Deceased bool `json:"deceased"`
	Name string `json:"name"`
}

type People []Person

// optional test 0
type OptionalTest0 *string

type OptionalTest1Value struct {
	Foo string `json:"foo"`
}

// optional test 1
type OptionalTest1 *OptionalTest1Value

// optional test 2
type OptionalTest2 *string

// list test 0
type ListTest0 []string

// list test 1
type ListTest1 [][]string

type ListTest2Values struct {
	Foo string `json:"foo"`
}

// list test 2
type ListTest2 []ListTest2Values

// set test 0
type SetTest0 []string

// set test 1
type SetTest1 []string

// set test 2
type SetTest2 [][]string

type SetTest3Values struct {
	Foo string `json:"foo"`
}

// set test 3
type SetTest3 []SetTest3Values

// map test 0
type MapTest0 map[string]string

// map test 1
type MapTest1 map[string]string

// map test 2
type MapTest2 map[string]map[string]string

type MapTest3Keys struct {
	Foo string `json:"foo"`
}

type MapTest3Values struct {
	Foo string `json:"foo"`
}

// map test 3
type MapTest3 map[MapTest3Keys]MapTest3Values

// oneOf test 0
type OneOfTest0Kind string

const (
	OneOfTest0KindTextValue OneOfTest0Kind = "TextValue"
	OneOfTest0KindNaturalValue OneOfTest0Kind = "NaturalValue"
)

type OneOfTest0 struct {
	Kind OneOfTest0Kind `json:"kind"`
	TextValue *string `json:"TextValue,omitempty"`
	NaturalValue *int `json:"NaturalValue,omitempty"`
}

// oneOf test 1
type OneOfTest1Kind string

const (
	OneOfTest1KindTextValue OneOfTest1Kind = "TextValue"
	OneOfTest1KindNaturalValue OneOfTest1Kind = "NaturalValue"
)

type OneOfTest1 struct {
	Kind OneOfTest1Kind `json:"kind"`
	TextValue *string `json:"TextValue,omitempty"`
	NaturalValue *int `json:"NaturalValue,omitempty"`
}

type OneOfTest2Option2 struct {
	Bar float64 `json:"bar"`
	Foo string `json:"foo"`
}

// oneOf test 2
type OneOfTest2Kind string

const (
	OneOfTest2KindTextValue OneOfTest2Kind = "TextValue"
	OneOfTest2KindNaturalValue OneOfTest2Kind = "NaturalValue"
	OneOfTest2KindDetails OneOfTest2Kind = "Details"
)

type OneOfTest2 struct {
	Kind OneOfTest2Kind `json:"kind"`
	TextValue *string `json:"TextValue,omitempty"`
	NaturalValue *int `json:"NaturalValue,omitempty"`
	Details *OneOfTest2Option2 `json:"Details,omitempty"`
}

// oneOf test 3
type OneOfTest3Kind string

const (
	OneOfTest3KindFooRef OneOfTest3Kind = "FooRef"
	OneOfTest3KindBarRef OneOfTest3Kind = "BarRef"
)

type OneOfTest3 struct {
	Kind OneOfTest3Kind `json:"kind"`
	FooRef *Foo `json:"FooRef,omitempty"`
	BarRef *Bar `json:"BarRef,omitempty"`
}

type AllOfTest0Option0 struct {
	Bar float64 `json:"bar"`
}

type AllOfTest0Option1 struct {
	Foo string `json:"foo"`
}

// allOf test 0
type AllOfTest0 struct {
	AllOfTest0Option0
	AllOfTest0Option1
}

// tuple test 0
type TupleTest0 struct {
	Item1 string `json:"item1"`
	Item2 int `json:"item2"`
}

// tuple test 1
type TupleTest1 struct {
	Item1 string `json:"item1"`
	Item2 int `json:"item2"`
}

// tuple test 2
type TupleTest2 struct {
	Item1 string `json:"item1"`
	Item2 struct {
		Item1 string `json:"item1"`
		Item2 int `json:"item2"`
	} `json:"item2"`
}

// record test 0
type RecordTest0 struct {
	Age int `json:"age"`
	Deceased bool `json:"deceased"`
	Name string `json:"name"`
}

// record test 1
type RecordTest1 struct {
	Age int `json:"age"`
	Deceased bool `json:"deceased"`
	Name string `json:"name"`
}

type RecordTest2Contact struct {
	Email *string `json:"email,omitempty"`
	Phone *string `json:"phone,omitempty"`
}

// record test 2
type RecordTest2 struct {
	Age int `json:"age"`
	Contact RecordTest2Contact `json:"contact"`
	Deceased bool `json:"deceased"`
	Name string `json:"name"`
}

// record test 3
type RecordTest3 struct {
	Name string `json:"name"`
	Age *int `json:"age,omitempty"`
	Deceased *bool `json:"deceased,omitempty"`
}

// record test 4
type RecordTest4 interface {
	Id() string
	Status() string
	Age() *int
}

// function test 0
type FunctionTest0 func()

// function test 1
type FunctionTest1 func()

// function test 2
type FunctionTest2 func(x0 bool)

// function test 3
type FunctionTest3 func(x0 bool)

// function test 4
type FunctionTest4 func(x0 bool, x1 float64, x2 string)

// function test 5
type FunctionTest5 func(x0 bool, x1 float64, x2 string)

// function test 6
type FunctionTest6 func()

// function test 7
type FunctionTest7 func()

// function test 8
type FunctionTest8 func() bool

// function test 9
type FunctionTest9 func() bool

// function test 10
type FunctionTest10 func() (bool, float64, string)

// function test 11
type FunctionTest11 func() (bool, float64, string)

// function test 12
type FunctionTest12 func(x0 int, x1 string) (string, bool)

// function test 13
type FunctionTest13 func(x0 int, x1 string) (string, bool)

type FunctionTest14Input struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

type FunctionTest14Output struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

// function test 14
type FunctionTest14 func(x0 FunctionTest14Input) FunctionTest14Output

type FunctionTest15Input0 struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

type FunctionTest15Input1 struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

type FunctionTest15Output0 struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

type FunctionTest15Output1 struct {
	Bar string `json:"bar"`
	Foo int `json:"foo"`
}

// function test 15
type FunctionTest15 func(x0 FunctionTest15Input0, x1 FunctionTest15Input1) (FunctionTest15Output0, FunctionTest15Output1)
