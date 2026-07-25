package models

import "time"

type Person struct {
	AppointmentTime string `json:"appointment_time"`
	BirthDate string `json:"birth_date"`
	CreatedAt string `json:"created_at"`
	DateOfBirth time.Time `json:"date_of_birth"`
	DestinationIp string `json:"destination_ip"`
	Friends []Person `json:"friends"`
	Id string `json:"id"`
	Name string `json:"name"`
	RetentionPeriod string `json:"retention_period"`
	SourceIp string `json:"source_ip"`
	ContactEmail *string `json:"contact_email,omitempty"`
}
