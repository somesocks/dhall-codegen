package models

import "time"

type Person struct {
	DateOfBirth time.Time `json:"date_of_birth"`
	Friends []Person `json:"friends"`
	Name string `json:"name"`
	ContactEmail *string `json:"contact_email,omitempty"`
}
