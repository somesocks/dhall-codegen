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
	err, encodedText := EncodeOneOfTest0(OneOfTest0{TextValue: &text})
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

func TestOneOfEncodeUsesFirstPopulatedField(t *testing.T) {
	base := OneOfTest5Option0{Foo: "base"}
	extended := OneOfTest5Option1{Foo: "extended", Bar: 1}
	err, encoded := EncodeOneOfTest5(OneOfTest5{BaseRecord: &base, ExtendedRecord: &extended})
	requireNoError(t, err)
	object, ok := encoded.(map[string]any)
	if !ok || object["foo"] != "base" {
		t.Fatalf("first populated union field did not win: %#v", encoded)
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
