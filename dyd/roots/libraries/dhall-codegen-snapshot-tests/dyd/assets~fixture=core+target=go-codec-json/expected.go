package models

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"math"
	"net"
	"net/url"
	"regexp"
	"strconv"
	"time"
)

type CodecError struct {
	Operation string
	Path string
	Message string
}

func (err CodecError) Error() string {
	return fmt.Sprintf("%s error at %s: %s", err.Operation, err.Path, err.Message)
}

func codecError(operation string, path string, message string) error {
	return CodecError{Operation: operation, Path: path, Message: message}
}

func pathField(path string, field string) string { return path + "." + field }
func pathIndex(path string, index int) string { return fmt.Sprintf("%s[%d]", path, index) }

func asObject(operation string, value any, path string) (error, map[string]any) {
	result, ok := value.(map[string]any)
	if !ok { return codecError(operation, path, "expected object"), nil }
	return nil, result
}

func asArray(operation string, value any, path string) (error, []any) {
	result, ok := value.([]any)
	if !ok { return codecError(operation, path, "expected array"), nil }
	return nil, result
}

func asString(operation string, value any, path string) (error, string) {
	result, ok := value.(string)
	if !ok { return codecError(operation, path, "expected string"), "" }
	return nil, result
}

func numberText(operation string, value any, path string) (error, string) {
	switch number := value.(type) {
	case json.Number:
		if _, err := number.Float64(); err != nil { return codecError(operation, path, "expected number"), "" }
		return nil, string(number)
	case float64:
		if math.IsNaN(number) || math.IsInf(number, 0) { return codecError(operation, path, "expected finite number"), "" }
		return nil, strconv.FormatFloat(number, 'g', -1, 64)
	default:
		return codecError(operation, path, "expected number"), ""
	}
}

func encodeFloat(value float64, path string) (error, any) {
	if math.IsNaN(value) || math.IsInf(value, 0) { return codecError("encode", path, "expected finite number"), nil }
	return nil, json.Number(strconv.FormatFloat(value, 'g', -1, 64))
}

func decodeFloat(value any, path string) (error, float64) {
	err, text := numberText("decode", value, path)
	if err != nil { return err, 0 }
	result, parseErr := strconv.ParseFloat(text, 64)
	if parseErr != nil || math.IsNaN(result) || math.IsInf(result, 0) { return codecError("decode", path, "expected finite number"), 0 }
	return nil, result
}

func encodeInteger(value int, natural bool, path string) (error, any) {
	if natural && value < 0 { return codecError("encode", path, "expected natural number"), nil }
	return nil, json.Number(strconv.Itoa(value))
}

func decodeInteger(value any, natural bool, path string) (error, int) {
	err, text := numberText("decode", value, path)
	if err != nil { return err, 0 }
	result, parseErr := strconv.ParseInt(text, 10, 0)
	if parseErr != nil || (natural && result < 0) { return codecError("decode", path, "expected integer"), 0 }
	return nil, int(result)
}

var emailPattern = regexp.MustCompile(`^[^@\s]+@[^@\s]+\.[^@\s]+$`)
var e164Pattern = regexp.MustCompile(`^\+[1-9][0-9]{1,14}$`)
var uuidPattern = regexp.MustCompile(`(?i)^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$`)

func validateText(variant string, value string, operation string, path string) (error, string) {
	switch variant {
	case "none": return nil, value
	case "email": if !emailPattern.MatchString(value) { return codecError(operation, path, "expected email"), "" }
	case "url": if _, err := url.ParseRequestURI(value); err != nil { return codecError(operation, path, "expected URL"), "" }
	case "base64": if _, err := base64.StdEncoding.DecodeString(value); err != nil { return codecError(operation, path, "expected Base64"), "" }
	case "base64url": if _, err := base64.URLEncoding.DecodeString(value); err != nil { return codecError(operation, path, "expected Base64url"), "" }
	case "e164": if !e164Pattern.MatchString(value) { return codecError(operation, path, "expected E.164 phone number"), "" }
	case "ipv4": if ip := net.ParseIP(value); ip == nil || ip.To4() == nil { return codecError(operation, path, "expected IPv4 address"), "" }
	case "ipv6": if ip := net.ParseIP(value); ip == nil || ip.To4() != nil { return codecError(operation, path, "expected IPv6 address"), "" }
	case "isoDate": if _, err := time.Parse("2006-01-02", value); err != nil { return codecError(operation, path, "expected ISO date"), "" }
	case "isoDateTime": if _, err := time.Parse(time.RFC3339, value); err != nil { return codecError(operation, path, "expected RFC 3339 date-time"), "" }
	case "isoDuration": if len(value) < 2 || value[0] != 'P' { return codecError(operation, path, "expected ISO duration"), "" }
	case "isoTime": if _, err := time.Parse("15:04:05", value); err != nil { return codecError(operation, path, "expected local ISO time"), "" }
	case "uuid": if !uuidPattern.MatchString(value) { return codecError(operation, path, "expected UUID"), "" }
	default:
		if len(variant) > 8 && variant[:8] == "literal:" && value == variant[8:] { return nil, value }
		return codecError(operation, path, "invalid text value"), ""
	}
	return nil, value
}

func encodeText(variant string, value string, path string) (error, any) {
	err, result := validateText(variant, value, "encode", path)
	if err != nil { return err, nil }
	return nil, result
}
func decodeText(variant string, value any, path string) (error, string) {
	err, text := asString("decode", value, path)
	if err != nil { return err, "" }
	return validateText(variant, text, "decode", path)
}

func encodeBoolean(value bool, path string) (error, any) { return nil, value }
func decodeBoolean(value any, path string) (error, bool) {
	result, ok := value.(bool)
	if !ok { return codecError("decode", path, "expected boolean"), false }
	return nil, result
}

func validateAny(operation string, value any, path string) (error, any) {
	switch typed := value.(type) {
	case nil, bool, string: return nil, value
	case float64, json.Number:
		if err, _ := numberText(operation, value, path); err != nil { return err, nil }
		return nil, value
	case []any:
		for index, entry := range typed { if err, _ := validateAny(operation, entry, pathIndex(path, index)); err != nil { return err, nil } }
		return nil, value
	case map[string]any:
		for key, entry := range typed { if err, _ := validateAny(operation, entry, pathField(path, key)); err != nil { return err, nil } }
		return nil, value
	default: return codecError(operation, path, "expected JSON value"), nil
	}
}

func encodeInstant(value time.Time, path string) (error, any) { return nil, value.Format(time.RFC3339Nano) }
func decodeInstant(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse(time.RFC3339, text); if parseErr != nil { return codecError("decode", path, "expected RFC 3339 date-time"), time.Time{} }
	return nil, result
}
func encodeDate(value time.Time, path string) (error, any) { return nil, value.Format("2006-01-02") }
func decodeDate(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse("2006-01-02", text); if parseErr != nil { return codecError("decode", path, "expected ISO date"), time.Time{} }
	return nil, result
}
func encodeLocalTime(value time.Time, path string) (error, any) { return nil, value.Format("15:04:05.999999999") }
func decodeLocalTime(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse("15:04:05", text); if parseErr != nil { return codecError("decode", path, "expected local ISO time"), time.Time{} }
	return nil, result
}
func encodeDuration(value string, path string) (error, any) { return encodeText("isoDuration", value, path) }
func decodeDuration(value any, path string) (error, string) { return decodeText("isoDuration", value, path) }





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

// text test 5
type TextTest5 string

// text test 6
type TextTest6 string

// text test 7
type TextTest7 string

// text test 8
type TextTest8 string

// text test 9
type TextTest9 string

// text test 10
type TextTest10 string

// text test 11
type TextTest11 string

// text test 12
type TextTest12 string

// text test 13
type TextTest13 string

// text test 14
type TextTest14 string

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

// time test 0
type TimeTest0 time.Time

// time test 1
type TimeTest1 time.Time

// time test 2
type TimeTest2 time.Time

// time test 3
type TimeTest3 time.Time

// time test 4
type TimeTest4 string

// any test 0
type AnyTest0 interface{}

// any test 1
type AnyTest1 interface{}

// any test 2
type AnyTest2 interface{}

// any test 3
type AnyTest3 interface{}

type Person struct {
	Age int `json:"age"`
	Deceased bool `json:"deceased"`
	Name string `json:"name"`
}

type People []Person

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

type OneOfTest4Option0 struct {
	Bar float64 `json:"bar"`
	Foo string `json:"foo"`
}

type OneOfTest4Option1 struct {
	Foo string `json:"foo"`
}

// oneOf test 4
type OneOfTest4Kind string

const (
	OneOfTest4KindExtendedRecord OneOfTest4Kind = "ExtendedRecord"
	OneOfTest4KindBaseRecord OneOfTest4Kind = "BaseRecord"
)

type OneOfTest4 struct {
	Kind OneOfTest4Kind `json:"kind"`
	ExtendedRecord *OneOfTest4Option0 `json:"ExtendedRecord,omitempty"`
	BaseRecord *OneOfTest4Option1 `json:"BaseRecord,omitempty"`
}

type OneOfTest5Option0 struct {
	Foo string `json:"foo"`
}

type OneOfTest5Option1 struct {
	Bar float64 `json:"bar"`
	Foo string `json:"foo"`
}

// oneOf test 5
type OneOfTest5Kind string

const (
	OneOfTest5KindBaseRecord OneOfTest5Kind = "BaseRecord"
	OneOfTest5KindExtendedRecord OneOfTest5Kind = "ExtendedRecord"
)

type OneOfTest5 struct {
	Kind OneOfTest5Kind `json:"kind"`
	BaseRecord *OneOfTest5Option0 `json:"BaseRecord,omitempty"`
	ExtendedRecord *OneOfTest5Option1 `json:"ExtendedRecord,omitempty"`
}

type Foo string

type Bar int




func EncodeBooleanTest0(value BooleanTest0) (err error, result any) {
	return encodeBooleanTest0At(value, "$")
}

func encodeBooleanTest0At(value BooleanTest0, path string) (err error, result any) {
	err, result = encodeBoolean((bool)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeBooleanTest0(input any) (err error, result BooleanTest0) {
	return decodeBooleanTest0At(input, "$")
}

func decodeBooleanTest0At(input any, path string) (err error, result BooleanTest0) {
	var decoded bool
	err, decoded = decodeBoolean(input, path)
	if err != nil {
		return err, result
	}
	result = BooleanTest0(decoded)
	return nil, result
}



func EncodeBooleanTest1(value BooleanTest1) (err error, result any) {
	return encodeBooleanTest1At(value, "$")
}

func encodeBooleanTest1At(value BooleanTest1, path string) (err error, result any) {
	err, result = encodeBoolean((bool)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeBooleanTest1(input any) (err error, result BooleanTest1) {
	return decodeBooleanTest1At(input, "$")
}

func decodeBooleanTest1At(input any, path string) (err error, result BooleanTest1) {
	var decoded bool
	err, decoded = decodeBoolean(input, path)
	if err != nil {
		return err, result
	}
	result = BooleanTest1(decoded)
	return nil, result
}



func EncodeBooleanTest2(value BooleanTest2) (err error, result any) {
	return encodeBooleanTest2At(value, "$")
}

func encodeBooleanTest2At(value BooleanTest2, path string) (err error, result any) {
	err, result = encodeBoolean((bool)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeBooleanTest2(input any) (err error, result BooleanTest2) {
	return decodeBooleanTest2At(input, "$")
}

func decodeBooleanTest2At(input any, path string) (err error, result BooleanTest2) {
	var decoded bool
	err, decoded = decodeBoolean(input, path)
	if err != nil {
		return err, result
	}
	result = BooleanTest2(decoded)
	return nil, result
}



func EncodeNumberTest0(value NumberTest0) (err error, result any) {
	return encodeNumberTest0At(value, "$")
}

func encodeNumberTest0At(value NumberTest0, path string) (err error, result any) {
	err, result = encodeFloat((float64)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeNumberTest0(input any) (err error, result NumberTest0) {
	return decodeNumberTest0At(input, "$")
}

func decodeNumberTest0At(input any, path string) (err error, result NumberTest0) {
	var decoded float64
	err, decoded = decodeFloat(input, path)
	if err != nil {
		return err, result
	}
	result = NumberTest0(decoded)
	return nil, result
}



func EncodeNumberTest1(value NumberTest1) (err error, result any) {
	return encodeNumberTest1At(value, "$")
}

func encodeNumberTest1At(value NumberTest1, path string) (err error, result any) {
	err, result = encodeFloat((float64)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeNumberTest1(input any) (err error, result NumberTest1) {
	return decodeNumberTest1At(input, "$")
}

func decodeNumberTest1At(input any, path string) (err error, result NumberTest1) {
	var decoded float64
	err, decoded = decodeFloat(input, path)
	if err != nil {
		return err, result
	}
	result = NumberTest1(decoded)
	return nil, result
}



func EncodeNumberTest2(value NumberTest2) (err error, result any) {
	return encodeNumberTest2At(value, "$")
}

func encodeNumberTest2At(value NumberTest2, path string) (err error, result any) {
	err, result = encodeInteger((int)(value), true, path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeNumberTest2(input any) (err error, result NumberTest2) {
	return decodeNumberTest2At(input, "$")
}

func decodeNumberTest2At(input any, path string) (err error, result NumberTest2) {
	var decoded int
	err, decoded = decodeInteger(input, true, path)
	if err != nil {
		return err, result
	}
	result = NumberTest2(decoded)
	return nil, result
}



func EncodeNumberTest3(value NumberTest3) (err error, result any) {
	return encodeNumberTest3At(value, "$")
}

func encodeNumberTest3At(value NumberTest3, path string) (err error, result any) {
	err, result = encodeInteger((int)(value), false, path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeNumberTest3(input any) (err error, result NumberTest3) {
	return decodeNumberTest3At(input, "$")
}

func decodeNumberTest3At(input any, path string) (err error, result NumberTest3) {
	var decoded int
	err, decoded = decodeInteger(input, false, path)
	if err != nil {
		return err, result
	}
	result = NumberTest3(decoded)
	return nil, result
}



func EncodeNumberTest4(value NumberTest4) (err error, result any) {
	return encodeNumberTest4At(value, "$")
}

func encodeNumberTest4At(value NumberTest4, path string) (err error, result any) {
	err, result = encodeFloat((float64)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeNumberTest4(input any) (err error, result NumberTest4) {
	return decodeNumberTest4At(input, "$")
}

func decodeNumberTest4At(input any, path string) (err error, result NumberTest4) {
	var decoded float64
	err, decoded = decodeFloat(input, path)
	if err != nil {
		return err, result
	}
	result = NumberTest4(decoded)
	return nil, result
}



func EncodeTextTest0(value TextTest0) (err error, result any) {
	return encodeTextTest0At(value, "$")
}

func encodeTextTest0At(value TextTest0, path string) (err error, result any) {
	err, result = encodeText("none", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest0(input any) (err error, result TextTest0) {
	return decodeTextTest0At(input, "$")
}

func decodeTextTest0At(input any, path string) (err error, result TextTest0) {
	var decoded string
	err, decoded = decodeText("none", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest0(decoded)
	return nil, result
}



func EncodeTextTest1(value TextTest1) (err error, result any) {
	return encodeTextTest1At(value, "$")
}

func encodeTextTest1At(value TextTest1, path string) (err error, result any) {
	err, result = encodeText("none", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest1(input any) (err error, result TextTest1) {
	return decodeTextTest1At(input, "$")
}

func decodeTextTest1At(input any, path string) (err error, result TextTest1) {
	var decoded string
	err, decoded = decodeText("none", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest1(decoded)
	return nil, result
}



func EncodeTextTest2(value TextTest2) (err error, result any) {
	return encodeTextTest2At(value, "$")
}

func encodeTextTest2At(value TextTest2, path string) (err error, result any) {
	err, result = encodeText("email", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest2(input any) (err error, result TextTest2) {
	return decodeTextTest2At(input, "$")
}

func decodeTextTest2At(input any, path string) (err error, result TextTest2) {
	var decoded string
	err, decoded = decodeText("email", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest2(decoded)
	return nil, result
}



func EncodeTextTest3(value TextTest3) (err error, result any) {
	return encodeTextTest3At(value, "$")
}

func encodeTextTest3At(value TextTest3, path string) (err error, result any) {
	err, result = encodeText("url", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest3(input any) (err error, result TextTest3) {
	return decodeTextTest3At(input, "$")
}

func decodeTextTest3At(input any, path string) (err error, result TextTest3) {
	var decoded string
	err, decoded = decodeText("url", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest3(decoded)
	return nil, result
}



func EncodeTextTest4(value TextTest4) (err error, result any) {
	return encodeTextTest4At(value, "$")
}

func encodeTextTest4At(value TextTest4, path string) (err error, result any) {
	err, result = encodeText("literal:foo", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest4(input any) (err error, result TextTest4) {
	return decodeTextTest4At(input, "$")
}

func decodeTextTest4At(input any, path string) (err error, result TextTest4) {
	var decoded string
	err, decoded = decodeText("literal:foo", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest4(decoded)
	return nil, result
}



func EncodeTextTest5(value TextTest5) (err error, result any) {
	return encodeTextTest5At(value, "$")
}

func encodeTextTest5At(value TextTest5, path string) (err error, result any) {
	err, result = encodeText("isoDateTime", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest5(input any) (err error, result TextTest5) {
	return decodeTextTest5At(input, "$")
}

func decodeTextTest5At(input any, path string) (err error, result TextTest5) {
	var decoded string
	err, decoded = decodeText("isoDateTime", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest5(decoded)
	return nil, result
}



func EncodeTextTest6(value TextTest6) (err error, result any) {
	return encodeTextTest6At(value, "$")
}

func encodeTextTest6At(value TextTest6, path string) (err error, result any) {
	err, result = encodeText("isoDate", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest6(input any) (err error, result TextTest6) {
	return decodeTextTest6At(input, "$")
}

func decodeTextTest6At(input any, path string) (err error, result TextTest6) {
	var decoded string
	err, decoded = decodeText("isoDate", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest6(decoded)
	return nil, result
}



func EncodeTextTest7(value TextTest7) (err error, result any) {
	return encodeTextTest7At(value, "$")
}

func encodeTextTest7At(value TextTest7, path string) (err error, result any) {
	err, result = encodeText("isoTime", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest7(input any) (err error, result TextTest7) {
	return decodeTextTest7At(input, "$")
}

func decodeTextTest7At(input any, path string) (err error, result TextTest7) {
	var decoded string
	err, decoded = decodeText("isoTime", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest7(decoded)
	return nil, result
}



func EncodeTextTest8(value TextTest8) (err error, result any) {
	return encodeTextTest8At(value, "$")
}

func encodeTextTest8At(value TextTest8, path string) (err error, result any) {
	err, result = encodeText("isoDuration", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest8(input any) (err error, result TextTest8) {
	return decodeTextTest8At(input, "$")
}

func decodeTextTest8At(input any, path string) (err error, result TextTest8) {
	var decoded string
	err, decoded = decodeText("isoDuration", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest8(decoded)
	return nil, result
}



func EncodeTextTest9(value TextTest9) (err error, result any) {
	return encodeTextTest9At(value, "$")
}

func encodeTextTest9At(value TextTest9, path string) (err error, result any) {
	err, result = encodeText("uuid", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest9(input any) (err error, result TextTest9) {
	return decodeTextTest9At(input, "$")
}

func decodeTextTest9At(input any, path string) (err error, result TextTest9) {
	var decoded string
	err, decoded = decodeText("uuid", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest9(decoded)
	return nil, result
}



func EncodeTextTest10(value TextTest10) (err error, result any) {
	return encodeTextTest10At(value, "$")
}

func encodeTextTest10At(value TextTest10, path string) (err error, result any) {
	err, result = encodeText("ipv4", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest10(input any) (err error, result TextTest10) {
	return decodeTextTest10At(input, "$")
}

func decodeTextTest10At(input any, path string) (err error, result TextTest10) {
	var decoded string
	err, decoded = decodeText("ipv4", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest10(decoded)
	return nil, result
}



func EncodeTextTest11(value TextTest11) (err error, result any) {
	return encodeTextTest11At(value, "$")
}

func encodeTextTest11At(value TextTest11, path string) (err error, result any) {
	err, result = encodeText("ipv6", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest11(input any) (err error, result TextTest11) {
	return decodeTextTest11At(input, "$")
}

func decodeTextTest11At(input any, path string) (err error, result TextTest11) {
	var decoded string
	err, decoded = decodeText("ipv6", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest11(decoded)
	return nil, result
}



func EncodeTextTest12(value TextTest12) (err error, result any) {
	return encodeTextTest12At(value, "$")
}

func encodeTextTest12At(value TextTest12, path string) (err error, result any) {
	err, result = encodeText("base64", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest12(input any) (err error, result TextTest12) {
	return decodeTextTest12At(input, "$")
}

func decodeTextTest12At(input any, path string) (err error, result TextTest12) {
	var decoded string
	err, decoded = decodeText("base64", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest12(decoded)
	return nil, result
}



func EncodeTextTest13(value TextTest13) (err error, result any) {
	return encodeTextTest13At(value, "$")
}

func encodeTextTest13At(value TextTest13, path string) (err error, result any) {
	err, result = encodeText("base64url", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest13(input any) (err error, result TextTest13) {
	return decodeTextTest13At(input, "$")
}

func decodeTextTest13At(input any, path string) (err error, result TextTest13) {
	var decoded string
	err, decoded = decodeText("base64url", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest13(decoded)
	return nil, result
}



func EncodeTextTest14(value TextTest14) (err error, result any) {
	return encodeTextTest14At(value, "$")
}

func encodeTextTest14At(value TextTest14, path string) (err error, result any) {
	err, result = encodeText("e164", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTextTest14(input any) (err error, result TextTest14) {
	return decodeTextTest14At(input, "$")
}

func decodeTextTest14At(input any, path string) (err error, result TextTest14) {
	var decoded string
	err, decoded = decodeText("e164", input, path)
	if err != nil {
		return err, result
	}
	result = TextTest14(decoded)
	return nil, result
}



func EncodeOptionalTest0(value OptionalTest0) (err error, result any) {
	return encodeOptionalTest0At(value, "$")
}

func encodeOptionalTest0At(value OptionalTest0, path string) (err error, result any) {
	if (*string)(value) == nil {
	result = nil
	} else {
	err, result = encodeText("none", *(*string)(value), path)
	if err != nil {
		return err, result
	}
	}
	return nil, result
}

func DecodeOptionalTest0(input any) (err error, result OptionalTest0) {
	return decodeOptionalTest0At(input, "$")
}

func decodeOptionalTest0At(input any, path string) (err error, result OptionalTest0) {
	var decoded *string
	if input == nil {
	decoded = nil
	} else {
	var decodedValue string
	err, decodedValue = decodeText("none", input, path)
	if err != nil {
		return err, result
	}
	decoded = &decodedValue
	}
	result = OptionalTest0(decoded)
	return nil, result
}



func EncodeOptionalTest1Value(value OptionalTest1Value) (err error, result any) {
	return encodeOptionalTest1ValueAt(value, "$")
}

func encodeOptionalTest1ValueAt(value OptionalTest1Value, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOptionalTest1Value(input any) (err error, result OptionalTest1Value) {
	return decodeOptionalTest1ValueAt(input, "$")
}

func decodeOptionalTest1ValueAt(input any, path string) (err error, result OptionalTest1Value) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OptionalTest1Value(decoded)
	return nil, result
}



func EncodeOptionalTest1(value OptionalTest1) (err error, result any) {
	return encodeOptionalTest1At(value, "$")
}

func encodeOptionalTest1At(value OptionalTest1, path string) (err error, result any) {
	if (*OptionalTest1Value)(value) == nil {
	result = nil
	} else {
	err, result = encodeOptionalTest1ValueAt(*(*OptionalTest1Value)(value), path)
	if err != nil {
		return err, result
	}
	}
	return nil, result
}

func DecodeOptionalTest1(input any) (err error, result OptionalTest1) {
	return decodeOptionalTest1At(input, "$")
}

func decodeOptionalTest1At(input any, path string) (err error, result OptionalTest1) {
	var decoded *OptionalTest1Value
	if input == nil {
	decoded = nil
	} else {
	var decodedValue OptionalTest1Value
	err, decodedValue = decodeOptionalTest1ValueAt(input, path)
	if err != nil {
		return err, result
	}
	decoded = &decodedValue
	}
	result = OptionalTest1(decoded)
	return nil, result
}



func EncodeOptionalTest2(value OptionalTest2) (err error, result any) {
	return encodeOptionalTest2At(value, "$")
}

func encodeOptionalTest2At(value OptionalTest2, path string) (err error, result any) {
	if (*string)(value) == nil {
	result = nil
	} else {
	err, result = encodeText("none", *(*string)(value), path)
	if err != nil {
		return err, result
	}
	}
	return nil, result
}

func DecodeOptionalTest2(input any) (err error, result OptionalTest2) {
	return decodeOptionalTest2At(input, "$")
}

func decodeOptionalTest2At(input any, path string) (err error, result OptionalTest2) {
	var decoded *string
	if input == nil {
	decoded = nil
	} else {
	var decodedValue string
	err, decodedValue = decodeText("none", input, path)
	if err != nil {
		return err, result
	}
	decoded = &decodedValue
	}
	result = OptionalTest2(decoded)
	return nil, result
}



func EncodeListTest0(value ListTest0) (err error, result any) {
	return encodeListTest0At(value, "$")
}

func encodeListTest0At(value ListTest0, path string) (err error, result any) {
	{
		entries := ([]string)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodeText("none", entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeListTest0(input any) (err error, result ListTest0) {
	return decodeListTest0At(input, "$")
}

func decodeListTest0At(input any, path string) (err error, result ListTest0) {
	var decoded []string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]string, len(entries))
		for index := range entries {
			var decodedEntry string
			err, decodedEntry = decodeText("none", entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = ListTest0(decoded)
	return nil, result
}



func EncodeListTest1(value ListTest1) (err error, result any) {
	return encodeListTest1At(value, "$")
}

func encodeListTest1At(value ListTest1, path string) (err error, result any) {
	{
		entries := ([][]string)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			{
				entries := entry
				encodedValues := make([]any, len(entries))
				for index, entry := range entries {
					var encodedEntry any
					err, encodedEntry = encodeText("none", entry, pathIndex(pathIndex(path, index), index))
					if err != nil {
						return err, result
					}
					encodedValues[index] = encodedEntry
				}
				encodedEntry = encodedValues
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeListTest1(input any) (err error, result ListTest1) {
	return decodeListTest1At(input, "$")
}

func decodeListTest1At(input any, path string) (err error, result ListTest1) {
	var decoded [][]string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([][]string, len(entries))
		for index := range entries {
			var decodedEntry []string
			{
				err, entries := asArray("decode", entries[index], pathIndex(path, index))
				if err != nil {
					return err, result
				}
				decodedValues := make([]string, len(entries))
				for index := range entries {
					var decodedEntry string
					err, decodedEntry = decodeText("none", entries[index], pathIndex(pathIndex(path, index), index))
					if err != nil {
						return err, result
					}
					decodedValues[index] = decodedEntry
				}
				decodedEntry = decodedValues
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = ListTest1(decoded)
	return nil, result
}



func EncodeListTest2Values(value ListTest2Values) (err error, result any) {
	return encodeListTest2ValuesAt(value, "$")
}

func encodeListTest2ValuesAt(value ListTest2Values, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeListTest2Values(input any) (err error, result ListTest2Values) {
	return decodeListTest2ValuesAt(input, "$")
}

func decodeListTest2ValuesAt(input any, path string) (err error, result ListTest2Values) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = ListTest2Values(decoded)
	return nil, result
}



func EncodeListTest2(value ListTest2) (err error, result any) {
	return encodeListTest2At(value, "$")
}

func encodeListTest2At(value ListTest2, path string) (err error, result any) {
	{
		entries := ([]ListTest2Values)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodeListTest2ValuesAt(entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeListTest2(input any) (err error, result ListTest2) {
	return decodeListTest2At(input, "$")
}

func decodeListTest2At(input any, path string) (err error, result ListTest2) {
	var decoded []ListTest2Values
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]ListTest2Values, len(entries))
		for index := range entries {
			var decodedEntry ListTest2Values
			err, decodedEntry = decodeListTest2ValuesAt(entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = ListTest2(decoded)
	return nil, result
}



func EncodeTupleTest0(value TupleTest0) (err error, result any) {
	return encodeTupleTest0At(value, "$")
}

func encodeTupleTest0At(value TupleTest0, path string) (err error, result any) {
	{
		encodedItems := make([]any, 2)
		var encodedRoot31Item1 any
		err, encodedRoot31Item1 = encodeText("none", (struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		})(value).Item1, pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		encodedItems[0] = encodedRoot31Item1
		var encodedRoot31Item2 any
		err, encodedRoot31Item2 = encodeInteger((struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		})(value).Item2, true, pathIndex(path, 1))
		if err != nil {
			return err, result
		}
		encodedItems[1] = encodedRoot31Item2
		result = encodedItems
	}
	return nil, result
}

func DecodeTupleTest0(input any) (err error, result TupleTest0) {
	return decodeTupleTest0At(input, "$")
}

func decodeTupleTest0At(input any, path string) (err error, result TupleTest0) {
	var decoded struct {
		Item1 string `json:"item1"`
		Item2 int `json:"item2"`
	}
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		if len(entries) != 2 {
			err = codecError("decode", path, "expected tuple of length 2")
			return err, result
		}
		var decodedRoot31Item1 string
		err, decodedRoot31Item1 = decodeText("none", entries[0], pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		decoded.Item1 = decodedRoot31Item1
		var decodedRoot31Item2 int
		err, decodedRoot31Item2 = decodeInteger(entries[1], true, pathIndex(path, 1))
		if err != nil {
			return err, result
		}
		decoded.Item2 = decodedRoot31Item2
	}
	result = TupleTest0(decoded)
	return nil, result
}



func EncodeTupleTest1(value TupleTest1) (err error, result any) {
	return encodeTupleTest1At(value, "$")
}

func encodeTupleTest1At(value TupleTest1, path string) (err error, result any) {
	{
		encodedItems := make([]any, 2)
		var encodedRoot32Item1 any
		err, encodedRoot32Item1 = encodeText("none", (struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		})(value).Item1, pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		encodedItems[0] = encodedRoot32Item1
		var encodedRoot32Item2 any
		err, encodedRoot32Item2 = encodeInteger((struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		})(value).Item2, true, pathIndex(path, 1))
		if err != nil {
			return err, result
		}
		encodedItems[1] = encodedRoot32Item2
		result = encodedItems
	}
	return nil, result
}

func DecodeTupleTest1(input any) (err error, result TupleTest1) {
	return decodeTupleTest1At(input, "$")
}

func decodeTupleTest1At(input any, path string) (err error, result TupleTest1) {
	var decoded struct {
		Item1 string `json:"item1"`
		Item2 int `json:"item2"`
	}
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		if len(entries) != 2 {
			err = codecError("decode", path, "expected tuple of length 2")
			return err, result
		}
		var decodedRoot32Item1 string
		err, decodedRoot32Item1 = decodeText("none", entries[0], pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		decoded.Item1 = decodedRoot32Item1
		var decodedRoot32Item2 int
		err, decodedRoot32Item2 = decodeInteger(entries[1], true, pathIndex(path, 1))
		if err != nil {
			return err, result
		}
		decoded.Item2 = decodedRoot32Item2
	}
	result = TupleTest1(decoded)
	return nil, result
}



func EncodeTupleTest2(value TupleTest2) (err error, result any) {
	return encodeTupleTest2At(value, "$")
}

func encodeTupleTest2At(value TupleTest2, path string) (err error, result any) {
	{
		encodedItems := make([]any, 2)
		var encodedRoot33Item1 any
		err, encodedRoot33Item1 = encodeText("none", (struct {
			Item1 string `json:"item1"`
			Item2 struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		} `json:"item2"`
		})(value).Item1, pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		encodedItems[0] = encodedRoot33Item1
		var encodedRoot33Item2 any
		{
			encodedItems := make([]any, 2)
			var encodedRoot33t2Item1 any
			err, encodedRoot33t2Item1 = encodeText("none", (struct {
				Item1 string `json:"item1"`
				Item2 struct {
				Item1 string `json:"item1"`
				Item2 int `json:"item2"`
			} `json:"item2"`
			})(value).Item2.Item1, pathIndex(pathIndex(path, 1), 0))
			if err != nil {
				return err, result
			}
			encodedItems[0] = encodedRoot33t2Item1
			var encodedRoot33t2Item2 any
			err, encodedRoot33t2Item2 = encodeInteger((struct {
				Item1 string `json:"item1"`
				Item2 struct {
				Item1 string `json:"item1"`
				Item2 int `json:"item2"`
			} `json:"item2"`
			})(value).Item2.Item2, true, pathIndex(pathIndex(path, 1), 1))
			if err != nil {
				return err, result
			}
			encodedItems[1] = encodedRoot33t2Item2
			encodedRoot33Item2 = encodedItems
		}
		encodedItems[1] = encodedRoot33Item2
		result = encodedItems
	}
	return nil, result
}

func DecodeTupleTest2(input any) (err error, result TupleTest2) {
	return decodeTupleTest2At(input, "$")
}

func decodeTupleTest2At(input any, path string) (err error, result TupleTest2) {
	var decoded struct {
		Item1 string `json:"item1"`
		Item2 struct {
		Item1 string `json:"item1"`
		Item2 int `json:"item2"`
	} `json:"item2"`
	}
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		if len(entries) != 2 {
			err = codecError("decode", path, "expected tuple of length 2")
			return err, result
		}
		var decodedRoot33Item1 string
		err, decodedRoot33Item1 = decodeText("none", entries[0], pathIndex(path, 0))
		if err != nil {
			return err, result
		}
		decoded.Item1 = decodedRoot33Item1
		var decodedRoot33Item2 struct {
			Item1 string `json:"item1"`
			Item2 int `json:"item2"`
		}
		{
			err, entries := asArray("decode", entries[1], pathIndex(path, 1))
			if err != nil {
				return err, result
			}
			if len(entries) != 2 {
				err = codecError("decode", pathIndex(path, 1), "expected tuple of length 2")
				return err, result
			}
			var decodedRoot33t2Item1 string
			err, decodedRoot33t2Item1 = decodeText("none", entries[0], pathIndex(pathIndex(path, 1), 0))
			if err != nil {
				return err, result
			}
			decodedRoot33Item2.Item1 = decodedRoot33t2Item1
			var decodedRoot33t2Item2 int
			err, decodedRoot33t2Item2 = decodeInteger(entries[1], true, pathIndex(pathIndex(path, 1), 1))
			if err != nil {
				return err, result
			}
			decodedRoot33Item2.Item2 = decodedRoot33t2Item2
		}
		decoded.Item2 = decodedRoot33Item2
	}
	result = TupleTest2(decoded)
	return nil, result
}



func EncodeSetTest0(value SetTest0) (err error, result any) {
	return encodeSetTest0At(value, "$")
}

func encodeSetTest0At(value SetTest0, path string) (err error, result any) {
	{
		entries := ([]string)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodeText("none", entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeSetTest0(input any) (err error, result SetTest0) {
	return decodeSetTest0At(input, "$")
}

func decodeSetTest0At(input any, path string) (err error, result SetTest0) {
	var decoded []string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]string, len(entries))
		for index := range entries {
			var decodedEntry string
			err, decodedEntry = decodeText("none", entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = SetTest0(decoded)
	return nil, result
}



func EncodeSetTest1(value SetTest1) (err error, result any) {
	return encodeSetTest1At(value, "$")
}

func encodeSetTest1At(value SetTest1, path string) (err error, result any) {
	{
		entries := ([]string)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodeText("none", entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeSetTest1(input any) (err error, result SetTest1) {
	return decodeSetTest1At(input, "$")
}

func decodeSetTest1At(input any, path string) (err error, result SetTest1) {
	var decoded []string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]string, len(entries))
		for index := range entries {
			var decodedEntry string
			err, decodedEntry = decodeText("none", entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = SetTest1(decoded)
	return nil, result
}



func EncodeSetTest2(value SetTest2) (err error, result any) {
	return encodeSetTest2At(value, "$")
}

func encodeSetTest2At(value SetTest2, path string) (err error, result any) {
	{
		entries := ([][]string)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			{
				entries := entry
				encodedValues := make([]any, len(entries))
				for index, entry := range entries {
					var encodedEntry any
					err, encodedEntry = encodeText("none", entry, pathIndex(pathIndex(path, index), index))
					if err != nil {
						return err, result
					}
					encodedValues[index] = encodedEntry
				}
				encodedEntry = encodedValues
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeSetTest2(input any) (err error, result SetTest2) {
	return decodeSetTest2At(input, "$")
}

func decodeSetTest2At(input any, path string) (err error, result SetTest2) {
	var decoded [][]string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([][]string, len(entries))
		for index := range entries {
			var decodedEntry []string
			{
				err, entries := asArray("decode", entries[index], pathIndex(path, index))
				if err != nil {
					return err, result
				}
				decodedValues := make([]string, len(entries))
				for index := range entries {
					var decodedEntry string
					err, decodedEntry = decodeText("none", entries[index], pathIndex(pathIndex(path, index), index))
					if err != nil {
						return err, result
					}
					decodedValues[index] = decodedEntry
				}
				decodedEntry = decodedValues
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = SetTest2(decoded)
	return nil, result
}



func EncodeSetTest3Values(value SetTest3Values) (err error, result any) {
	return encodeSetTest3ValuesAt(value, "$")
}

func encodeSetTest3ValuesAt(value SetTest3Values, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeSetTest3Values(input any) (err error, result SetTest3Values) {
	return decodeSetTest3ValuesAt(input, "$")
}

func decodeSetTest3ValuesAt(input any, path string) (err error, result SetTest3Values) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = SetTest3Values(decoded)
	return nil, result
}



func EncodeSetTest3(value SetTest3) (err error, result any) {
	return encodeSetTest3At(value, "$")
}

func encodeSetTest3At(value SetTest3, path string) (err error, result any) {
	{
		entries := ([]SetTest3Values)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodeSetTest3ValuesAt(entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodeSetTest3(input any) (err error, result SetTest3) {
	return decodeSetTest3At(input, "$")
}

func decodeSetTest3At(input any, path string) (err error, result SetTest3) {
	var decoded []SetTest3Values
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]SetTest3Values, len(entries))
		for index := range entries {
			var decodedEntry SetTest3Values
			err, decodedEntry = decodeSetTest3ValuesAt(entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = SetTest3(decoded)
	return nil, result
}



func EncodeMapTest0(value MapTest0) (err error, result any) {
	return encodeMapTest0At(value, "$")
}

func encodeMapTest0At(value MapTest0, path string) (err error, result any) {
	{
		encodedEntries := make([]any, 0, len((map[string]string)(value)))
		for key, entry := range (map[string]string)(value) {
			var encodedKey any
			err, encodedKey = encodeText("none", key, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			var encodedValue any
			err, encodedValue = encodeText("none", entry, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			encodedEntries = append(encodedEntries, map[string]any{"key": encodedKey, "value": encodedValue})
		}
		result = encodedEntries
	}
	return nil, result
}

func DecodeMapTest0(input any) (err error, result MapTest0) {
	return decodeMapTest0At(input, "$")
}

func decodeMapTest0At(input any, path string) (err error, result MapTest0) {
	var decoded map[string]string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedMap := make(map[string]string, len(entries))
		for index, entry := range entries {
			entryObject, ok := entry.(map[string]any)
			if !ok { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			rawKey, hasKey := entryObject["key"]
			rawValue, hasValue := entryObject["value"]
			if !hasKey || !hasValue { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			var decodedKey string
			err, decodedKey = decodeText("none", rawKey, pathField(pathIndex(path, index), "key"))
			if err != nil {
				return err, result
			}
			var decodedValue string
			err, decodedValue = decodeText("none", rawValue, pathField(pathIndex(path, index), "value"))
			if err != nil {
				return err, result
			}
			decodedMap[decodedKey] = decodedValue
		}
		decoded = decodedMap
	}
	result = MapTest0(decoded)
	return nil, result
}



func EncodeMapTest1(value MapTest1) (err error, result any) {
	return encodeMapTest1At(value, "$")
}

func encodeMapTest1At(value MapTest1, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any, len((map[string]string)(value)))
		for key, entry := range (map[string]string)(value) {
			var encodedKey any
			err, encodedKey = encodeText("none", key, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			wireKey, ok := encodedKey.(string)
			if !ok { err = codecError("encode", path, "record map keys must encode as strings"); return err, result }
			var encodedValue any
			err, encodedValue = encodeText("none", entry, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			encodedObject[wireKey] = encodedValue
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeMapTest1(input any) (err error, result MapTest1) {
	return decodeMapTest1At(input, "$")
}

func decodeMapTest1At(input any, path string) (err error, result MapTest1) {
	var decoded map[string]string
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedMap := make(map[string]string, len(object))
		for key, rawValue := range object {
			rawKey := any(key)
			var decodedKey string
			err, decodedKey = decodeText("none", rawKey, pathField(path, key))
			if err != nil {
				return err, result
			}
			var decodedValue string
			err, decodedValue = decodeText("none", rawValue, pathField(path, key))
			if err != nil {
				return err, result
			}
			decodedMap[decodedKey] = decodedValue
		}
		decoded = decodedMap
	}
	result = MapTest1(decoded)
	return nil, result
}



func EncodeMapTest2(value MapTest2) (err error, result any) {
	return encodeMapTest2At(value, "$")
}

func encodeMapTest2At(value MapTest2, path string) (err error, result any) {
	{
		encodedEntries := make([]any, 0, len((map[string]map[string]string)(value)))
		for key, entry := range (map[string]map[string]string)(value) {
			var encodedKey any
			err, encodedKey = encodeText("none", key, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			var encodedValue any
			{
				encodedEntries := make([]any, 0, len(entry))
				for key, entry := range entry {
					var encodedKey any
					err, encodedKey = encodeText("none", key, pathField(pathField(path, fmt.Sprint(key)), fmt.Sprint(key)))
					if err != nil {
						return err, result
					}
					var encodedValue any
					err, encodedValue = encodeText("none", entry, pathField(pathField(path, fmt.Sprint(key)), fmt.Sprint(key)))
					if err != nil {
						return err, result
					}
					encodedEntries = append(encodedEntries, map[string]any{"key": encodedKey, "value": encodedValue})
				}
				encodedValue = encodedEntries
			}
			encodedEntries = append(encodedEntries, map[string]any{"key": encodedKey, "value": encodedValue})
		}
		result = encodedEntries
	}
	return nil, result
}

func DecodeMapTest2(input any) (err error, result MapTest2) {
	return decodeMapTest2At(input, "$")
}

func decodeMapTest2At(input any, path string) (err error, result MapTest2) {
	var decoded map[string]map[string]string
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedMap := make(map[string]map[string]string, len(entries))
		for index, entry := range entries {
			entryObject, ok := entry.(map[string]any)
			if !ok { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			rawKey, hasKey := entryObject["key"]
			rawValue, hasValue := entryObject["value"]
			if !hasKey || !hasValue { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			var decodedKey string
			err, decodedKey = decodeText("none", rawKey, pathField(pathIndex(path, index), "key"))
			if err != nil {
				return err, result
			}
			var decodedValue map[string]string
			{
				err, entries := asArray("decode", rawValue, pathField(pathIndex(path, index), "value"))
				if err != nil {
					return err, result
				}
				decodedMap := make(map[string]string, len(entries))
				for index, entry := range entries {
					entryObject, ok := entry.(map[string]any)
					if !ok { err = codecError("decode", pathIndex(pathField(pathIndex(path, index), "value"), index), "expected map entry"); return err, result }
					rawKey, hasKey := entryObject["key"]
					rawValue, hasValue := entryObject["value"]
					if !hasKey || !hasValue { err = codecError("decode", pathIndex(pathField(pathIndex(path, index), "value"), index), "expected map entry"); return err, result }
					var decodedKey string
					err, decodedKey = decodeText("none", rawKey, pathField(pathIndex(pathField(pathIndex(path, index), "value"), index), "key"))
					if err != nil {
						return err, result
					}
					var decodedValue string
					err, decodedValue = decodeText("none", rawValue, pathField(pathIndex(pathField(pathIndex(path, index), "value"), index), "value"))
					if err != nil {
						return err, result
					}
					decodedMap[decodedKey] = decodedValue
				}
				decodedValue = decodedMap
			}
			decodedMap[decodedKey] = decodedValue
		}
		decoded = decodedMap
	}
	result = MapTest2(decoded)
	return nil, result
}



func EncodeMapTest3Keys(value MapTest3Keys) (err error, result any) {
	return encodeMapTest3KeysAt(value, "$")
}

func encodeMapTest3KeysAt(value MapTest3Keys, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeMapTest3Keys(input any) (err error, result MapTest3Keys) {
	return decodeMapTest3KeysAt(input, "$")
}

func decodeMapTest3KeysAt(input any, path string) (err error, result MapTest3Keys) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = MapTest3Keys(decoded)
	return nil, result
}



func EncodeMapTest3Values(value MapTest3Values) (err error, result any) {
	return encodeMapTest3ValuesAt(value, "$")
}

func encodeMapTest3ValuesAt(value MapTest3Values, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeMapTest3Values(input any) (err error, result MapTest3Values) {
	return decodeMapTest3ValuesAt(input, "$")
}

func decodeMapTest3ValuesAt(input any, path string) (err error, result MapTest3Values) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = MapTest3Values(decoded)
	return nil, result
}



func EncodeMapTest3(value MapTest3) (err error, result any) {
	return encodeMapTest3At(value, "$")
}

func encodeMapTest3At(value MapTest3, path string) (err error, result any) {
	{
		encodedEntries := make([]any, 0, len((map[MapTest3Keys]MapTest3Values)(value)))
		for key, entry := range (map[MapTest3Keys]MapTest3Values)(value) {
			var encodedKey any
			err, encodedKey = encodeMapTest3KeysAt(key, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			var encodedValue any
			err, encodedValue = encodeMapTest3ValuesAt(entry, pathField(path, fmt.Sprint(key)))
			if err != nil {
				return err, result
			}
			encodedEntries = append(encodedEntries, map[string]any{"key": encodedKey, "value": encodedValue})
		}
		result = encodedEntries
	}
	return nil, result
}

func DecodeMapTest3(input any) (err error, result MapTest3) {
	return decodeMapTest3At(input, "$")
}

func decodeMapTest3At(input any, path string) (err error, result MapTest3) {
	var decoded map[MapTest3Keys]MapTest3Values
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedMap := make(map[MapTest3Keys]MapTest3Values, len(entries))
		for index, entry := range entries {
			entryObject, ok := entry.(map[string]any)
			if !ok { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			rawKey, hasKey := entryObject["key"]
			rawValue, hasValue := entryObject["value"]
			if !hasKey || !hasValue { err = codecError("decode", pathIndex(path, index), "expected map entry"); return err, result }
			var decodedKey MapTest3Keys
			err, decodedKey = decodeMapTest3KeysAt(rawKey, pathField(pathIndex(path, index), "key"))
			if err != nil {
				return err, result
			}
			var decodedValue MapTest3Values
			err, decodedValue = decodeMapTest3ValuesAt(rawValue, pathField(pathIndex(path, index), "value"))
			if err != nil {
				return err, result
			}
			decodedMap[decodedKey] = decodedValue
		}
		decoded = decodedMap
	}
	result = MapTest3(decoded)
	return nil, result
}



func EncodeRecordTest0(value RecordTest0) (err error, result any) {
	return encodeRecordTest0At(value, "$")
}

func encodeRecordTest0At(value RecordTest0, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["age"] = encodeInteger((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Age, true, pathField(path, "age"))
		if err != nil {
			return err, result
		}
		err, encodedObject["deceased"] = encodeBoolean((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Deceased, pathField(path, "deceased"))
		if err != nil {
			return err, result
		}
		err, encodedObject["name"] = encodeText("none", (struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Name, pathField(path, "name"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest0(input any) (err error, result RecordTest0) {
	return decodeRecordTest0At(input, "$")
}

func decodeRecordTest0At(input any, path string) (err error, result RecordTest0) {
	var decoded struct {
		Age int `json:"age"`
		Deceased bool `json:"deceased"`
		Name string `json:"name"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["age"]
			if !exists {
				err = codecError("decode", pathField(path, "age"), "missing required field")
				return err, result
			}
			err, decoded.Age = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["deceased"]
			if !exists {
				err = codecError("decode", pathField(path, "deceased"), "missing required field")
				return err, result
			}
			err, decoded.Deceased = decodeBoolean(rawValue, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
	}
	result = RecordTest0(decoded)
	return nil, result
}



func EncodeRecordTest1(value RecordTest1) (err error, result any) {
	return encodeRecordTest1At(value, "$")
}

func encodeRecordTest1At(value RecordTest1, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["age"] = encodeInteger((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Age, true, pathField(path, "age"))
		if err != nil {
			return err, result
		}
		err, encodedObject["deceased"] = encodeBoolean((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Deceased, pathField(path, "deceased"))
		if err != nil {
			return err, result
		}
		err, encodedObject["name"] = encodeText("none", (struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Name, pathField(path, "name"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest1(input any) (err error, result RecordTest1) {
	return decodeRecordTest1At(input, "$")
}

func decodeRecordTest1At(input any, path string) (err error, result RecordTest1) {
	var decoded struct {
		Age int `json:"age"`
		Deceased bool `json:"deceased"`
		Name string `json:"name"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["age"]
			if !exists {
				err = codecError("decode", pathField(path, "age"), "missing required field")
				return err, result
			}
			err, decoded.Age = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["deceased"]
			if !exists {
				err = codecError("decode", pathField(path, "deceased"), "missing required field")
				return err, result
			}
			err, decoded.Deceased = decodeBoolean(rawValue, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
	}
	result = RecordTest1(decoded)
	return nil, result
}



func EncodeRecordTest2Contact(value RecordTest2Contact) (err error, result any) {
	return encodeRecordTest2ContactAt(value, "$")
}

func encodeRecordTest2ContactAt(value RecordTest2Contact, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		if (struct {
			Email *string `json:"email,omitempty"`
			Phone *string `json:"phone,omitempty"`
		})(value).Email != nil {
			err, encodedObject["email"] = encodeText("none", *(struct {
				Email *string `json:"email,omitempty"`
				Phone *string `json:"phone,omitempty"`
			})(value).Email, pathField(path, "email"))
			if err != nil {
				return err, result
			}
		}
		if (struct {
			Email *string `json:"email,omitempty"`
			Phone *string `json:"phone,omitempty"`
		})(value).Phone != nil {
			err, encodedObject["phone"] = encodeText("none", *(struct {
				Email *string `json:"email,omitempty"`
				Phone *string `json:"phone,omitempty"`
			})(value).Phone, pathField(path, "phone"))
			if err != nil {
				return err, result
			}
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest2Contact(input any) (err error, result RecordTest2Contact) {
	return decodeRecordTest2ContactAt(input, "$")
}

func decodeRecordTest2ContactAt(input any, path string) (err error, result RecordTest2Contact) {
	var decoded struct {
		Email *string `json:"email,omitempty"`
		Phone *string `json:"phone,omitempty"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		if rawValue, exists := object["email"]; exists {
			var decodedValue string
			err, decodedValue = decodeText("none", rawValue, pathField(path, "email"))
			if err != nil {
				return err, result
			}
			decoded.Email = &decodedValue
		}
		if rawValue, exists := object["phone"]; exists {
			var decodedValue string
			err, decodedValue = decodeText("none", rawValue, pathField(path, "phone"))
			if err != nil {
				return err, result
			}
			decoded.Phone = &decodedValue
		}
	}
	result = RecordTest2Contact(decoded)
	return nil, result
}



func EncodeRecordTest2(value RecordTest2) (err error, result any) {
	return encodeRecordTest2At(value, "$")
}

func encodeRecordTest2At(value RecordTest2, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["age"] = encodeInteger((struct {
			Age int `json:"age"`
			Contact RecordTest2Contact `json:"contact"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Age, true, pathField(path, "age"))
		if err != nil {
			return err, result
		}
		err, encodedObject["contact"] = encodeRecordTest2ContactAt((struct {
			Age int `json:"age"`
			Contact RecordTest2Contact `json:"contact"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Contact, pathField(path, "contact"))
		if err != nil {
			return err, result
		}
		err, encodedObject["deceased"] = encodeBoolean((struct {
			Age int `json:"age"`
			Contact RecordTest2Contact `json:"contact"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Deceased, pathField(path, "deceased"))
		if err != nil {
			return err, result
		}
		err, encodedObject["name"] = encodeText("none", (struct {
			Age int `json:"age"`
			Contact RecordTest2Contact `json:"contact"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Name, pathField(path, "name"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest2(input any) (err error, result RecordTest2) {
	return decodeRecordTest2At(input, "$")
}

func decodeRecordTest2At(input any, path string) (err error, result RecordTest2) {
	var decoded struct {
		Age int `json:"age"`
		Contact RecordTest2Contact `json:"contact"`
		Deceased bool `json:"deceased"`
		Name string `json:"name"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["age"]
			if !exists {
				err = codecError("decode", pathField(path, "age"), "missing required field")
				return err, result
			}
			err, decoded.Age = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["contact"]
			if !exists {
				err = codecError("decode", pathField(path, "contact"), "missing required field")
				return err, result
			}
			err, decoded.Contact = decodeRecordTest2ContactAt(rawValue, pathField(path, "contact"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["deceased"]
			if !exists {
				err = codecError("decode", pathField(path, "deceased"), "missing required field")
				return err, result
			}
			err, decoded.Deceased = decodeBoolean(rawValue, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
	}
	result = RecordTest2(decoded)
	return nil, result
}



func EncodeRecordTest3(value RecordTest3) (err error, result any) {
	return encodeRecordTest3At(value, "$")
}

func encodeRecordTest3At(value RecordTest3, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["name"] = encodeText("none", (struct {
			Name string `json:"name"`
			Age *int `json:"age,omitempty"`
			Deceased *bool `json:"deceased,omitempty"`
		})(value).Name, pathField(path, "name"))
		if err != nil {
			return err, result
		}
		if (struct {
			Name string `json:"name"`
			Age *int `json:"age,omitempty"`
			Deceased *bool `json:"deceased,omitempty"`
		})(value).Age != nil {
			err, encodedObject["age"] = encodeInteger(*(struct {
				Name string `json:"name"`
				Age *int `json:"age,omitempty"`
				Deceased *bool `json:"deceased,omitempty"`
			})(value).Age, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		if (struct {
			Name string `json:"name"`
			Age *int `json:"age,omitempty"`
			Deceased *bool `json:"deceased,omitempty"`
		})(value).Deceased != nil {
			err, encodedObject["deceased"] = encodeBoolean(*(struct {
				Name string `json:"name"`
				Age *int `json:"age,omitempty"`
				Deceased *bool `json:"deceased,omitempty"`
			})(value).Deceased, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest3(input any) (err error, result RecordTest3) {
	return decodeRecordTest3At(input, "$")
}

func decodeRecordTest3At(input any, path string) (err error, result RecordTest3) {
	var decoded struct {
		Name string `json:"name"`
		Age *int `json:"age,omitempty"`
		Deceased *bool `json:"deceased,omitempty"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
		if rawValue, exists := object["age"]; exists {
			var decodedValue int
			err, decodedValue = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
			decoded.Age = &decodedValue
		}
		if rawValue, exists := object["deceased"]; exists {
			var decodedValue bool
			err, decodedValue = decodeBoolean(rawValue, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
			decoded.Deceased = &decodedValue
		}
	}
	result = RecordTest3(decoded)
	return nil, result
}

type codecRecordTest4Impl struct {
	ValueId string
	ValueStatus string
	ValueAge *int
}

func (value codecRecordTest4Impl) Id() string {
	return value.ValueId
}

func (value codecRecordTest4Impl) Status() string {
	return value.ValueStatus
}

func (value codecRecordTest4Impl) Age() *int {
	return value.ValueAge
}

func EncodeRecordTest4(value RecordTest4) (err error, result any) {
	return encodeRecordTest4At(value, "$")
}

func encodeRecordTest4At(value RecordTest4, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["id"] = encodeText("none", (interface {
			Id() string
			Status() string
			Age() *int
		})(value).Id(), pathField(path, "id"))
		if err != nil {
			return err, result
		}
		err, encodedObject["status"] = encodeText("none", (interface {
			Id() string
			Status() string
			Age() *int
		})(value).Status(), pathField(path, "status"))
		if err != nil {
			return err, result
		}
		if (interface {
			Id() string
			Status() string
			Age() *int
		})(value).Age() != nil {
			err, encodedObject["age"] = encodeInteger(*(interface {
				Id() string
				Status() string
				Age() *int
			})(value).Age(), true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeRecordTest4(input any) (err error, result RecordTest4) {
	return decodeRecordTest4At(input, "$")
}

func decodeRecordTest4At(input any, path string) (err error, result RecordTest4) {
	var decoded interface {
		Id() string
		Status() string
		Age() *int
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		implementation := codecRecordTest4Impl{}
		{
			rawValue, exists := object["id"]
			if !exists {
				err = codecError("decode", pathField(path, "id"), "missing required field")
				return err, result
			}
			err, implementation.ValueId = decodeText("none", rawValue, pathField(path, "id"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["status"]
			if !exists {
				err = codecError("decode", pathField(path, "status"), "missing required field")
				return err, result
			}
			err, implementation.ValueStatus = decodeText("none", rawValue, pathField(path, "status"))
			if err != nil {
				return err, result
			}
		}
		if rawValue, exists := object["age"]; exists {
			var decodedValue int
			err, decodedValue = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
			implementation.ValueAge = &decodedValue
		}
		decoded = implementation
	}
	result = RecordTest4(decoded)
	return nil, result
}



func EncodeTimeTest0(value TimeTest0) (err error, result any) {
	return encodeTimeTest0At(value, "$")
}

func encodeTimeTest0At(value TimeTest0, path string) (err error, result any) {
	err, result = encodeInstant((time.Time)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTimeTest0(input any) (err error, result TimeTest0) {
	return decodeTimeTest0At(input, "$")
}

func decodeTimeTest0At(input any, path string) (err error, result TimeTest0) {
	var decoded time.Time
	err, decoded = decodeInstant(input, path)
	if err != nil {
		return err, result
	}
	result = TimeTest0(decoded)
	return nil, result
}



func EncodeTimeTest1(value TimeTest1) (err error, result any) {
	return encodeTimeTest1At(value, "$")
}

func encodeTimeTest1At(value TimeTest1, path string) (err error, result any) {
	err, result = encodeInstant((time.Time)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTimeTest1(input any) (err error, result TimeTest1) {
	return decodeTimeTest1At(input, "$")
}

func decodeTimeTest1At(input any, path string) (err error, result TimeTest1) {
	var decoded time.Time
	err, decoded = decodeInstant(input, path)
	if err != nil {
		return err, result
	}
	result = TimeTest1(decoded)
	return nil, result
}



func EncodeTimeTest2(value TimeTest2) (err error, result any) {
	return encodeTimeTest2At(value, "$")
}

func encodeTimeTest2At(value TimeTest2, path string) (err error, result any) {
	err, result = encodeDate((time.Time)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTimeTest2(input any) (err error, result TimeTest2) {
	return decodeTimeTest2At(input, "$")
}

func decodeTimeTest2At(input any, path string) (err error, result TimeTest2) {
	var decoded time.Time
	err, decoded = decodeDate(input, path)
	if err != nil {
		return err, result
	}
	result = TimeTest2(decoded)
	return nil, result
}



func EncodeTimeTest3(value TimeTest3) (err error, result any) {
	return encodeTimeTest3At(value, "$")
}

func encodeTimeTest3At(value TimeTest3, path string) (err error, result any) {
	err, result = encodeLocalTime((time.Time)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTimeTest3(input any) (err error, result TimeTest3) {
	return decodeTimeTest3At(input, "$")
}

func decodeTimeTest3At(input any, path string) (err error, result TimeTest3) {
	var decoded time.Time
	err, decoded = decodeLocalTime(input, path)
	if err != nil {
		return err, result
	}
	result = TimeTest3(decoded)
	return nil, result
}



func EncodeTimeTest4(value TimeTest4) (err error, result any) {
	return encodeTimeTest4At(value, "$")
}

func encodeTimeTest4At(value TimeTest4, path string) (err error, result any) {
	err, result = encodeDuration((string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeTimeTest4(input any) (err error, result TimeTest4) {
	return decodeTimeTest4At(input, "$")
}

func decodeTimeTest4At(input any, path string) (err error, result TimeTest4) {
	var decoded string
	err, decoded = decodeDuration(input, path)
	if err != nil {
		return err, result
	}
	result = TimeTest4(decoded)
	return nil, result
}



func EncodeAnyTest0(value AnyTest0) (err error, result any) {
	return encodeAnyTest0At(value, "$")
}

func encodeAnyTest0At(value AnyTest0, path string) (err error, result any) {
	err, result = validateAny("encode", (any)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeAnyTest0(input any) (err error, result AnyTest0) {
	return decodeAnyTest0At(input, "$")
}

func decodeAnyTest0At(input any, path string) (err error, result AnyTest0) {
	var decoded any
	err, decoded = validateAny("decode", input, path)
	if err != nil {
		return err, result
	}
	result = AnyTest0(decoded)
	return nil, result
}



func EncodeAnyTest1(value AnyTest1) (err error, result any) {
	return encodeAnyTest1At(value, "$")
}

func encodeAnyTest1At(value AnyTest1, path string) (err error, result any) {
	err, result = validateAny("encode", (any)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeAnyTest1(input any) (err error, result AnyTest1) {
	return decodeAnyTest1At(input, "$")
}

func decodeAnyTest1At(input any, path string) (err error, result AnyTest1) {
	var decoded any
	err, decoded = validateAny("decode", input, path)
	if err != nil {
		return err, result
	}
	result = AnyTest1(decoded)
	return nil, result
}



func EncodeAnyTest2(value AnyTest2) (err error, result any) {
	return encodeAnyTest2At(value, "$")
}

func encodeAnyTest2At(value AnyTest2, path string) (err error, result any) {
	err, result = validateAny("encode", (any)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeAnyTest2(input any) (err error, result AnyTest2) {
	return decodeAnyTest2At(input, "$")
}

func decodeAnyTest2At(input any, path string) (err error, result AnyTest2) {
	var decoded any
	err, decoded = validateAny("decode", input, path)
	if err != nil {
		return err, result
	}
	result = AnyTest2(decoded)
	return nil, result
}



func EncodeAnyTest3(value AnyTest3) (err error, result any) {
	return encodeAnyTest3At(value, "$")
}

func encodeAnyTest3At(value AnyTest3, path string) (err error, result any) {
	err, result = validateAny("encode", (any)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeAnyTest3(input any) (err error, result AnyTest3) {
	return decodeAnyTest3At(input, "$")
}

func decodeAnyTest3At(input any, path string) (err error, result AnyTest3) {
	var decoded any
	err, decoded = validateAny("decode", input, path)
	if err != nil {
		return err, result
	}
	result = AnyTest3(decoded)
	return nil, result
}



func EncodePerson(value Person) (err error, result any) {
	return encodePersonAt(value, "$")
}

func encodePersonAt(value Person, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["age"] = encodeInteger((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Age, true, pathField(path, "age"))
		if err != nil {
			return err, result
		}
		err, encodedObject["deceased"] = encodeBoolean((struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Deceased, pathField(path, "deceased"))
		if err != nil {
			return err, result
		}
		err, encodedObject["name"] = encodeText("none", (struct {
			Age int `json:"age"`
			Deceased bool `json:"deceased"`
			Name string `json:"name"`
		})(value).Name, pathField(path, "name"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodePerson(input any) (err error, result Person) {
	return decodePersonAt(input, "$")
}

func decodePersonAt(input any, path string) (err error, result Person) {
	var decoded struct {
		Age int `json:"age"`
		Deceased bool `json:"deceased"`
		Name string `json:"name"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["age"]
			if !exists {
				err = codecError("decode", pathField(path, "age"), "missing required field")
				return err, result
			}
			err, decoded.Age = decodeInteger(rawValue, true, pathField(path, "age"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["deceased"]
			if !exists {
				err = codecError("decode", pathField(path, "deceased"), "missing required field")
				return err, result
			}
			err, decoded.Deceased = decodeBoolean(rawValue, pathField(path, "deceased"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
	}
	result = Person(decoded)
	return nil, result
}



func EncodePeople(value People) (err error, result any) {
	return encodePeopleAt(value, "$")
}

func encodePeopleAt(value People, path string) (err error, result any) {
	{
		entries := ([]Person)(value)
		encodedValues := make([]any, len(entries))
		for index, entry := range entries {
			var encodedEntry any
			err, encodedEntry = encodePersonAt(entry, pathIndex(path, index))
			if err != nil {
				return err, result
			}
			encodedValues[index] = encodedEntry
		}
		result = encodedValues
	}
	return nil, result
}

func DecodePeople(input any) (err error, result People) {
	return decodePeopleAt(input, "$")
}

func decodePeopleAt(input any, path string) (err error, result People) {
	var decoded []Person
	{
		err, entries := asArray("decode", input, path)
		if err != nil {
			return err, result
		}
		decodedValues := make([]Person, len(entries))
		for index := range entries {
			var decodedEntry Person
			err, decodedEntry = decodePersonAt(entries[index], pathIndex(path, index))
			if err != nil {
				return err, result
			}
			decodedValues[index] = decodedEntry
		}
		decoded = decodedValues
	}
	result = People(decoded)
	return nil, result
}



func EncodeOneOfTest0(value OneOfTest0) (err error, result any) {
	return encodeOneOfTest0At(value, "$")
}

func encodeOneOfTest0At(value OneOfTest0, path string) (err error, result any) {
	{
		if (OneOfTest0)(value).TextValue != nil {
			err, result = encodeText("none", *(OneOfTest0)(value).TextValue, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest0)(value).NaturalValue != nil {
			err, result = encodeInteger(*(OneOfTest0)(value).NaturalValue, true, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest0(input any) (err error, result OneOfTest0) {
	return decodeOneOfTest0At(input, "$")
}

func decodeOneOfTest0At(input any, path string) (err error, result OneOfTest0) {
	var decoded OneOfTest0
	{
		matched := false
		if !matched {
			oneOfRoot62Option1:
			for {
				var decodedValue string
				err, decodedValue = decodeText("none", input, path)
				if err != nil {
					break oneOfRoot62Option1
				}
				decoded = OneOfTest0{Kind: OneOfTest0KindTextValue, TextValue: &decodedValue}
				matched = true
				break oneOfRoot62Option1
			}
		}
		if !matched {
			oneOfRoot62Option2:
			for {
				var decodedValue int
				err, decodedValue = decodeInteger(input, true, path)
				if err != nil {
					break oneOfRoot62Option2
				}
				decoded = OneOfTest0{Kind: OneOfTest0KindNaturalValue, NaturalValue: &decodedValue}
				matched = true
				break oneOfRoot62Option2
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest0(decoded)
	return nil, result
}



func EncodeOneOfTest1(value OneOfTest1) (err error, result any) {
	return encodeOneOfTest1At(value, "$")
}

func encodeOneOfTest1At(value OneOfTest1, path string) (err error, result any) {
	{
		if (OneOfTest1)(value).TextValue != nil {
			err, result = encodeText("none", *(OneOfTest1)(value).TextValue, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest1)(value).NaturalValue != nil {
			err, result = encodeInteger(*(OneOfTest1)(value).NaturalValue, true, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest1(input any) (err error, result OneOfTest1) {
	return decodeOneOfTest1At(input, "$")
}

func decodeOneOfTest1At(input any, path string) (err error, result OneOfTest1) {
	var decoded OneOfTest1
	{
		matched := false
		if !matched {
			oneOfRoot63Option1:
			for {
				var decodedValue string
				err, decodedValue = decodeText("none", input, path)
				if err != nil {
					break oneOfRoot63Option1
				}
				decoded = OneOfTest1{Kind: OneOfTest1KindTextValue, TextValue: &decodedValue}
				matched = true
				break oneOfRoot63Option1
			}
		}
		if !matched {
			oneOfRoot63Option2:
			for {
				var decodedValue int
				err, decodedValue = decodeInteger(input, true, path)
				if err != nil {
					break oneOfRoot63Option2
				}
				decoded = OneOfTest1{Kind: OneOfTest1KindNaturalValue, NaturalValue: &decodedValue}
				matched = true
				break oneOfRoot63Option2
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest1(decoded)
	return nil, result
}



func EncodeOneOfTest2Option2(value OneOfTest2Option2) (err error, result any) {
	return encodeOneOfTest2Option2At(value, "$")
}

func encodeOneOfTest2Option2At(value OneOfTest2Option2, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["bar"] = encodeFloat((struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Bar, pathField(path, "bar"))
		if err != nil {
			return err, result
		}
		err, encodedObject["foo"] = encodeText("none", (struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOneOfTest2Option2(input any) (err error, result OneOfTest2Option2) {
	return decodeOneOfTest2Option2At(input, "$")
}

func decodeOneOfTest2Option2At(input any, path string) (err error, result OneOfTest2Option2) {
	var decoded struct {
		Bar float64 `json:"bar"`
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["bar"]
			if !exists {
				err = codecError("decode", pathField(path, "bar"), "missing required field")
				return err, result
			}
			err, decoded.Bar = decodeFloat(rawValue, pathField(path, "bar"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OneOfTest2Option2(decoded)
	return nil, result
}



func EncodeOneOfTest2(value OneOfTest2) (err error, result any) {
	return encodeOneOfTest2At(value, "$")
}

func encodeOneOfTest2At(value OneOfTest2, path string) (err error, result any) {
	{
		if (OneOfTest2)(value).TextValue != nil {
			err, result = encodeText("none", *(OneOfTest2)(value).TextValue, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest2)(value).NaturalValue != nil {
			err, result = encodeInteger(*(OneOfTest2)(value).NaturalValue, true, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest2)(value).Details != nil {
			err, result = encodeOneOfTest2Option2At(*(OneOfTest2)(value).Details, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest2(input any) (err error, result OneOfTest2) {
	return decodeOneOfTest2At(input, "$")
}

func decodeOneOfTest2At(input any, path string) (err error, result OneOfTest2) {
	var decoded OneOfTest2
	{
		matched := false
		if !matched {
			oneOfRoot65Option1:
			for {
				var decodedValue string
				err, decodedValue = decodeText("none", input, path)
				if err != nil {
					break oneOfRoot65Option1
				}
				decoded = OneOfTest2{Kind: OneOfTest2KindTextValue, TextValue: &decodedValue}
				matched = true
				break oneOfRoot65Option1
			}
		}
		if !matched {
			oneOfRoot65Option2:
			for {
				var decodedValue int
				err, decodedValue = decodeInteger(input, true, path)
				if err != nil {
					break oneOfRoot65Option2
				}
				decoded = OneOfTest2{Kind: OneOfTest2KindNaturalValue, NaturalValue: &decodedValue}
				matched = true
				break oneOfRoot65Option2
			}
		}
		if !matched {
			oneOfRoot65Option3:
			for {
				var decodedValue OneOfTest2Option2
				err, decodedValue = decodeOneOfTest2Option2At(input, path)
				if err != nil {
					break oneOfRoot65Option3
				}
				decoded = OneOfTest2{Kind: OneOfTest2KindDetails, Details: &decodedValue}
				matched = true
				break oneOfRoot65Option3
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest2(decoded)
	return nil, result
}



func EncodeOneOfTest3(value OneOfTest3) (err error, result any) {
	return encodeOneOfTest3At(value, "$")
}

func encodeOneOfTest3At(value OneOfTest3, path string) (err error, result any) {
	{
		if (OneOfTest3)(value).FooRef != nil {
			err, result = encodeFooAt(*(OneOfTest3)(value).FooRef, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest3)(value).BarRef != nil {
			err, result = encodeBarAt(*(OneOfTest3)(value).BarRef, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest3(input any) (err error, result OneOfTest3) {
	return decodeOneOfTest3At(input, "$")
}

func decodeOneOfTest3At(input any, path string) (err error, result OneOfTest3) {
	var decoded OneOfTest3
	{
		matched := false
		if !matched {
			oneOfRoot66Option1:
			for {
				var decodedValue Foo
				err, decodedValue = decodeFooAt(input, path)
				if err != nil {
					break oneOfRoot66Option1
				}
				decoded = OneOfTest3{Kind: OneOfTest3KindFooRef, FooRef: &decodedValue}
				matched = true
				break oneOfRoot66Option1
			}
		}
		if !matched {
			oneOfRoot66Option2:
			for {
				var decodedValue Bar
				err, decodedValue = decodeBarAt(input, path)
				if err != nil {
					break oneOfRoot66Option2
				}
				decoded = OneOfTest3{Kind: OneOfTest3KindBarRef, BarRef: &decodedValue}
				matched = true
				break oneOfRoot66Option2
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest3(decoded)
	return nil, result
}



func EncodeOneOfTest4Option0(value OneOfTest4Option0) (err error, result any) {
	return encodeOneOfTest4Option0At(value, "$")
}

func encodeOneOfTest4Option0At(value OneOfTest4Option0, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["bar"] = encodeFloat((struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Bar, pathField(path, "bar"))
		if err != nil {
			return err, result
		}
		err, encodedObject["foo"] = encodeText("none", (struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOneOfTest4Option0(input any) (err error, result OneOfTest4Option0) {
	return decodeOneOfTest4Option0At(input, "$")
}

func decodeOneOfTest4Option0At(input any, path string) (err error, result OneOfTest4Option0) {
	var decoded struct {
		Bar float64 `json:"bar"`
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["bar"]
			if !exists {
				err = codecError("decode", pathField(path, "bar"), "missing required field")
				return err, result
			}
			err, decoded.Bar = decodeFloat(rawValue, pathField(path, "bar"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OneOfTest4Option0(decoded)
	return nil, result
}



func EncodeOneOfTest4Option1(value OneOfTest4Option1) (err error, result any) {
	return encodeOneOfTest4Option1At(value, "$")
}

func encodeOneOfTest4Option1At(value OneOfTest4Option1, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOneOfTest4Option1(input any) (err error, result OneOfTest4Option1) {
	return decodeOneOfTest4Option1At(input, "$")
}

func decodeOneOfTest4Option1At(input any, path string) (err error, result OneOfTest4Option1) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OneOfTest4Option1(decoded)
	return nil, result
}



func EncodeOneOfTest4(value OneOfTest4) (err error, result any) {
	return encodeOneOfTest4At(value, "$")
}

func encodeOneOfTest4At(value OneOfTest4, path string) (err error, result any) {
	{
		if (OneOfTest4)(value).ExtendedRecord != nil {
			err, result = encodeOneOfTest4Option0At(*(OneOfTest4)(value).ExtendedRecord, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest4)(value).BaseRecord != nil {
			err, result = encodeOneOfTest4Option1At(*(OneOfTest4)(value).BaseRecord, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest4(input any) (err error, result OneOfTest4) {
	return decodeOneOfTest4At(input, "$")
}

func decodeOneOfTest4At(input any, path string) (err error, result OneOfTest4) {
	var decoded OneOfTest4
	{
		matched := false
		if !matched {
			oneOfRoot69Option1:
			for {
				var decodedValue OneOfTest4Option0
				err, decodedValue = decodeOneOfTest4Option0At(input, path)
				if err != nil {
					break oneOfRoot69Option1
				}
				decoded = OneOfTest4{Kind: OneOfTest4KindExtendedRecord, ExtendedRecord: &decodedValue}
				matched = true
				break oneOfRoot69Option1
			}
		}
		if !matched {
			oneOfRoot69Option2:
			for {
				var decodedValue OneOfTest4Option1
				err, decodedValue = decodeOneOfTest4Option1At(input, path)
				if err != nil {
					break oneOfRoot69Option2
				}
				decoded = OneOfTest4{Kind: OneOfTest4KindBaseRecord, BaseRecord: &decodedValue}
				matched = true
				break oneOfRoot69Option2
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest4(decoded)
	return nil, result
}



func EncodeOneOfTest5Option0(value OneOfTest5Option0) (err error, result any) {
	return encodeOneOfTest5Option0At(value, "$")
}

func encodeOneOfTest5Option0At(value OneOfTest5Option0, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["foo"] = encodeText("none", (struct {
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOneOfTest5Option0(input any) (err error, result OneOfTest5Option0) {
	return decodeOneOfTest5Option0At(input, "$")
}

func decodeOneOfTest5Option0At(input any, path string) (err error, result OneOfTest5Option0) {
	var decoded struct {
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OneOfTest5Option0(decoded)
	return nil, result
}



func EncodeOneOfTest5Option1(value OneOfTest5Option1) (err error, result any) {
	return encodeOneOfTest5Option1At(value, "$")
}

func encodeOneOfTest5Option1At(value OneOfTest5Option1, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		err, encodedObject["bar"] = encodeFloat((struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Bar, pathField(path, "bar"))
		if err != nil {
			return err, result
		}
		err, encodedObject["foo"] = encodeText("none", (struct {
			Bar float64 `json:"bar"`
			Foo string `json:"foo"`
		})(value).Foo, pathField(path, "foo"))
		if err != nil {
			return err, result
		}
		result = encodedObject
	}
	return nil, result
}

func DecodeOneOfTest5Option1(input any) (err error, result OneOfTest5Option1) {
	return decodeOneOfTest5Option1At(input, "$")
}

func decodeOneOfTest5Option1At(input any, path string) (err error, result OneOfTest5Option1) {
	var decoded struct {
		Bar float64 `json:"bar"`
		Foo string `json:"foo"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["bar"]
			if !exists {
				err = codecError("decode", pathField(path, "bar"), "missing required field")
				return err, result
			}
			err, decoded.Bar = decodeFloat(rawValue, pathField(path, "bar"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["foo"]
			if !exists {
				err = codecError("decode", pathField(path, "foo"), "missing required field")
				return err, result
			}
			err, decoded.Foo = decodeText("none", rawValue, pathField(path, "foo"))
			if err != nil {
				return err, result
			}
		}
	}
	result = OneOfTest5Option1(decoded)
	return nil, result
}



func EncodeOneOfTest5(value OneOfTest5) (err error, result any) {
	return encodeOneOfTest5At(value, "$")
}

func encodeOneOfTest5At(value OneOfTest5, path string) (err error, result any) {
	{
		if (OneOfTest5)(value).BaseRecord != nil {
			err, result = encodeOneOfTest5Option0At(*(OneOfTest5)(value).BaseRecord, path)
			if err != nil {
				return err, result
			}
		} else if (OneOfTest5)(value).ExtendedRecord != nil {
			err, result = encodeOneOfTest5Option1At(*(OneOfTest5)(value).ExtendedRecord, path)
			if err != nil {
				return err, result
			}
		} else {
			err = codecError("encode", path, "no OneOf option matched")
			return err, result
		}
	}
	return nil, result
}

func DecodeOneOfTest5(input any) (err error, result OneOfTest5) {
	return decodeOneOfTest5At(input, "$")
}

func decodeOneOfTest5At(input any, path string) (err error, result OneOfTest5) {
	var decoded OneOfTest5
	{
		matched := false
		if !matched {
			oneOfRoot72Option1:
			for {
				var decodedValue OneOfTest5Option0
				err, decodedValue = decodeOneOfTest5Option0At(input, path)
				if err != nil {
					break oneOfRoot72Option1
				}
				decoded = OneOfTest5{Kind: OneOfTest5KindBaseRecord, BaseRecord: &decodedValue}
				matched = true
				break oneOfRoot72Option1
			}
		}
		if !matched {
			oneOfRoot72Option2:
			for {
				var decodedValue OneOfTest5Option1
				err, decodedValue = decodeOneOfTest5Option1At(input, path)
				if err != nil {
					break oneOfRoot72Option2
				}
				decoded = OneOfTest5{Kind: OneOfTest5KindExtendedRecord, ExtendedRecord: &decodedValue}
				matched = true
				break oneOfRoot72Option2
			}
		}
		if !matched {
			err = codecError("decode", path, "no OneOf option matched")
			return err, result
		}
	}
	result = OneOfTest5(decoded)
	return nil, result
}



func EncodeFoo(value Foo) (err error, result any) {
	return encodeFooAt(value, "$")
}

func encodeFooAt(value Foo, path string) (err error, result any) {
	err, result = encodeText("none", (string)(value), path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeFoo(input any) (err error, result Foo) {
	return decodeFooAt(input, "$")
}

func decodeFooAt(input any, path string) (err error, result Foo) {
	var decoded string
	err, decoded = decodeText("none", input, path)
	if err != nil {
		return err, result
	}
	result = Foo(decoded)
	return nil, result
}



func EncodeBar(value Bar) (err error, result any) {
	return encodeBarAt(value, "$")
}

func encodeBarAt(value Bar, path string) (err error, result any) {
	err, result = encodeInteger((int)(value), true, path)
	if err != nil {
		return err, result
	}
	return nil, result
}

func DecodeBar(input any) (err error, result Bar) {
	return decodeBarAt(input, "$")
}

func decodeBarAt(input any, path string) (err error, result Bar) {
	var decoded int
	err, decoded = decodeInteger(input, true, path)
	if err != nil {
		return err, result
	}
	result = Bar(decoded)
	return nil, result
}