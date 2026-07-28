package models

import (
	"testing"
	"time"
)

func TestPersonCodecRoundTrip(t *testing.T) {
	email := "ada@example.com"
	person := Person{
		AppointmentTime:  time.Date(2000, time.January, 1, 14, 30, 0, 0, time.UTC),
		BinaryData:       "+/8=",
		BirthDate:        "1815-12-10",
		Contact:          PersonContact{PhoneNumber: "+14155552671", Email: &email},
		CreatedAt:        "2026-07-25T14:30:00Z",
		DateOfBirth:      time.Date(1815, time.December, 10, 0, 0, 0, 0, time.UTC),
		DestinationIp:    "2001:db8::1",
		Id:               "123e4567-e89b-42d3-a456-426614174000",
		Name:             "Ada Lovelace",
		RetentionPeriod:  "P1Y2M3DT4H5M6S",
		SourceIp:         "192.0.2.1",
		Token:            "-_8=",
	}

	err, encoded := EncodePerson(person)
	if err != nil {
		t.Fatal(err)
	}
	object, ok := encoded.(map[string]any)
	if !ok || object["name"] != person.Name {
		t.Fatalf("unexpected encoded person: %#v", encoded)
	}

	err, decoded := DecodePerson(encoded)
	if err != nil {
		t.Fatal(err)
	}
	if decoded.Name != person.Name || decoded.Contact.Email == nil || *decoded.Contact.Email != email {
		t.Fatalf("unexpected decoded person: %#v", decoded)
	}
}
