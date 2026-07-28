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
