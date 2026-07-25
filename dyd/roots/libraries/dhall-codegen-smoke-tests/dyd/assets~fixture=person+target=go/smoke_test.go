package models

import (
	"encoding/json"
	"testing"
	"time"
)

func TestPersonJSONRoundTrip(t *testing.T) {
	email := "ada@example.com"
	p := Person{
		AppointmentTime: "14:30:00.123+02:00",
		BirthDate:    "1815-12-10",
		DateOfBirth:  time.Date(1815, time.December, 10, 0, 0, 0, 0, time.UTC),
		Friends:      []Person{{AppointmentTime: "09:00:00Z", BirthDate: "1906-12-09", Name: "Grace", DateOfBirth: time.Date(1906, time.December, 9, 0, 0, 0, 0, time.UTC)}},
		Name:         "Ada Lovelace",
		ContactEmail: &email,
	}

	encoded, err := json.Marshal(p)
	if err != nil {
		t.Fatalf("marshal person: %v", err)
	}

	var decoded Person
	if err := json.Unmarshal(encoded, &decoded); err != nil {
		t.Fatalf("unmarshal person: %v", err)
	}

	if decoded.Name != p.Name {
		t.Fatalf("unexpected name: got %q want %q", decoded.Name, p.Name)
	}
}
