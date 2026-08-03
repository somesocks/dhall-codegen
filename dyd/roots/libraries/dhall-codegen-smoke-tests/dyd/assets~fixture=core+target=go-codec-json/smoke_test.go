package models

import (
	"encoding/json"
	"testing"
)

func requireNoError(t *testing.T, err error) {
	t.Helper()
	if err != nil {
		t.Fatal(err)
	}
}

func TestJSONNumberRoundTrip(t *testing.T) {
	err, encoded := EncodeNumberTest2(NumberTest2(42))
	requireNoError(t, err)
	if number, ok := encoded.(json.Number); !ok || number != "42" {
		t.Fatalf("unexpected encoded natural: %#v", encoded)
	}

	err, decoded := DecodeNumberTest2(json.Number("42"))
	requireNoError(t, err)
	if decoded != NumberTest2(42) {
		t.Fatalf("unexpected decoded natural: %d", decoded)
	}
}

func TestRecordMapEncoding(t *testing.T) {
	err, encoded := EncodeRecordTest5(RecordTest5{
		Headers: map[string]string{"x-trace": "trace-1"},
	})
	requireNoError(t, err)

	object, ok := encoded.(map[string]any)
	if !ok {
		t.Fatal("record encoder did not return an object")
	}
	headers, ok := object["headers"].(map[string]any)
	if !ok {
		t.Fatal("record encoder omitted headers")
	}
	if headers["x-trace"] != "trace-1" {
		t.Fatalf("unexpected encoded headers: %#v", headers)
	}
}

func TestNestedMapDecodeErrorPath(t *testing.T) {
	err, _ := DecodeMapTest2([]any{
		map[string]any{"key": "first", "value": []any{}},
		map[string]any{
			"key": "second",
			"value": []any{
				map[string]any{"key": "inner", "value": json.Number("1")},
			},
		},
	})
	if err == nil {
		t.Fatal("expected invalid nested map value to fail")
	}
	if err.Error() != "decode error at $[1].value[0].value: expected string" {
		t.Fatalf("unexpected nested map error path: %v", err)
	}
}

func TestOptionalMapValueDecode(t *testing.T) {
	err, decoded := DecodeMapTest4([]any{
		map[string]any{"key": "label", "value": "value"},
	})
	requireNoError(t, err)
	if decoded["label"] == nil || *decoded["label"] != "value" {
		t.Fatalf("unexpected decoded optional map value: %#v", decoded)
	}
}

func TestOneOfFirstMatch(t *testing.T) {
	text := "text value"
	err, encodedText := EncodeOneOfTest0(OneOfTest0{Kind: OneOfTest0KindTextValue, TextValue: &text})
	requireNoError(t, err)
	if encodedText != text {
		t.Fatalf("unexpected encoded text: %#v", encodedText)
	}

	err, decodedText := DecodeOneOfTest0(encodedText)
	requireNoError(t, err)
	if decodedText.TextValue == nil || *decodedText.TextValue != text || decodedText.Kind != OneOfTest0KindTextValue {
		t.Fatalf("unexpected decoded text union: %#v", decodedText)
	}

	err, extendedFirst := DecodeOneOfTest4(map[string]any{"foo": "overlap", "bar": json.Number("1")})
	requireNoError(t, err)
	if extendedFirst.ExtendedRecord == nil || extendedFirst.ExtendedRecord.Bar != 1 || extendedFirst.BaseRecord != nil {
		t.Fatalf("extended-first union selected the wrong option: %#v", extendedFirst)
	}

	err, baseFirst := DecodeOneOfTest5(map[string]any{"foo": "overlap", "bar": json.Number("1")})
	requireNoError(t, err)
	if baseFirst.BaseRecord == nil || baseFirst.BaseRecord.Foo != "overlap" || baseFirst.ExtendedRecord != nil {
		t.Fatalf("base-first union selected the wrong option: %#v", baseFirst)
	}
}

func TestOneOfEncodeUsesKind(t *testing.T) {
	base := OneOfTest5Option0{Foo: "base"}
	extended := OneOfTest5Option1{Foo: "extended", Bar: 1}
	err, encoded := EncodeOneOfTest5(OneOfTest5{
		Kind:           OneOfTest5KindExtendedRecord,
		BaseRecord:     &base,
		ExtendedRecord: &extended,
	})
	requireNoError(t, err)
	object, ok := encoded.(map[string]any)
	if !ok || object["foo"] != "extended" || object["bar"] != json.Number("1") {
		t.Fatalf("Kind did not select the union field: %#v", encoded)
	}
}

func TestOneOfEncodeRequiresSelectedField(t *testing.T) {
	base := OneOfTest5Option0{Foo: "base"}
	err, _ := EncodeOneOfTest5(OneOfTest5{
		Kind:       OneOfTest5KindExtendedRecord,
		BaseRecord: &base,
	})
	if err == nil {
		t.Fatal("expected missing selected union field to fail")
	}
	if err.Error() != "encode error at $: malformed union struct: nil ExtendedRecord field" {
		t.Fatalf("unexpected missing selected union field error: %v", err)
	}
}

func TestOneOfEncodeRejectsUnknownKind(t *testing.T) {
	extended := OneOfTest5Option1{Foo: "extended", Bar: 1}
	err, _ := EncodeOneOfTest5(OneOfTest5{
		Kind:           OneOfTest5Kind("unknown"),
		ExtendedRecord: &extended,
	})
	if err == nil {
		t.Fatal("expected unknown union Kind to fail")
	}
	if err.Error() != "encode error at $: malformed union struct: Kind is missing or unknown" {
		t.Fatalf("unexpected unknown union Kind error: %v", err)
	}
}

func TestInterfaceRecordCodecRoundTrip(t *testing.T) {
	err, decoded := DecodeRecordTest4(map[string]any{
		"id":     "person-1",
		"status": "active",
		"age":    json.Number("36"),
	})
	requireNoError(t, err)
	if decoded.Id() != "person-1" || decoded.Status() != "active" || decoded.Age() == nil || *decoded.Age() != 36 {
		t.Fatalf("unexpected decoded interface record")
	}

	err, encoded := EncodeRecordTest4(decoded)
	requireNoError(t, err)
	object, ok := encoded.(map[string]any)
	if !ok || object["id"] != "person-1" || object["status"] != "active" {
		t.Fatalf("unexpected encoded interface record: %#v", encoded)
	}
}

func TestOptionalRecordNullFields(t *testing.T) {
	err, nested := DecodeRecordTest2(map[string]any{
		"age":     json.Number("36"),
		"contact": map[string]any{"email": nil, "phone": nil},
		"deceased": false,
		"name":    "Ada",
	})
	requireNoError(t, err)
	if nested.Contact.Email != nil || nested.Contact.Phone != nil {
		t.Fatalf("null nested optional fields were not absent: %#v", nested)
	}

	err, optional := DecodeRecordTest3(map[string]any{"name": "Ada", "age": nil, "deceased": nil})
	requireNoError(t, err)
	if optional.Age != nil || optional.Deceased != nil {
		t.Fatalf("null optional fields were not absent: %#v", optional)
	}

	err, interfaceRecord := DecodeRecordTest4(map[string]any{"id": "person-1", "status": "active", "age": nil})
	requireNoError(t, err)
	if interfaceRecord.Age() != nil {
		t.Fatalf("null interface optional field was not absent: %#v", interfaceRecord)
	}
}

func TestOptionalNestedOneOfRoundTrip(t *testing.T) {
	err, absent := DecodeOptionalNestedOneOf(map[string]any{"name": "local"})
	requireNoError(t, err)
	if absent.Value != nil {
		t.Fatalf("absent nested union was decoded: %#v", absent)
	}

	err, text := DecodeOptionalNestedOneOf(map[string]any{
		"name": "local",
		"value": map[string]any{"type": "text", "content": "hello"},
	})
	requireNoError(t, err)
	if text.Value == nil || text.Value.Kind != OptionalNestedOneOfValueKindTextValue || text.Value.TextValue == nil || text.Value.TextValue.Content != "hello" {
		t.Fatalf("unexpected decoded text value: %#v", text)
	}

	err, encoded := EncodeOptionalNestedOneOf(text)
	requireNoError(t, err)
	object, ok := encoded.(map[string]any)
	if !ok {
		t.Fatalf("unexpected encoded record: %#v", encoded)
	}
	value, ok := object["value"].(map[string]any)
	if !ok || value["type"] != "text" || value["content"] != "hello" {
		t.Fatalf("unexpected encoded text value: %#v", encoded)
	}

	err, empty := DecodeOptionalNestedOneOf(map[string]any{
		"name": "local",
		"value": map[string]any{"type": "empty"},
	})
	requireNoError(t, err)
	if empty.Value == nil || empty.Value.Kind != OptionalNestedOneOfValueKindEmptyValue || empty.Value.EmptyValue == nil {
		t.Fatalf("unexpected decoded empty value: %#v", empty)
	}

	err, encoded = EncodeOptionalNestedOneOf(empty)
	requireNoError(t, err)
	object, ok = encoded.(map[string]any)
	if !ok {
		t.Fatalf("unexpected encoded record: %#v", encoded)
	}
	value, ok = object["value"].(map[string]any)
	if !ok || value["type"] != "empty" {
		t.Fatalf("unexpected encoded empty value: %#v", encoded)
	}
}
