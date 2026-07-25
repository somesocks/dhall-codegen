package models

import "time"

type Person struct {
	AppointmentTime string `json:"appointment_time"`
	BirthDate string `json:"birth_date"`
	CreatedAt string `json:"created_at"`
	DateOfBirth time.Time `json:"date_of_birth"`
	Friends []Person `json:"friends"`
	Name string `json:"name"`
	ContactEmail *string `json:"contact_email,omitempty"`
}
