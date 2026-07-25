package models

import "time"

type Person struct {
	AppointmentTime time.Time `json:"appointment_time"`
	BinaryData string `json:"binary_data"`
	BirthDate string `json:"birth_date"`
	CreatedAt string `json:"created_at"`
	DateOfBirth time.Time `json:"date_of_birth"`
	DestinationIp string `json:"destination_ip"`
	Friends []Person `json:"friends"`
	Id string `json:"id"`
	Name string `json:"name"`
	PhoneNumber string `json:"phone_number"`
	RetentionPeriod string `json:"retention_period"`
	SourceIp string `json:"source_ip"`
	Token string `json:"token"`
	ContactEmail *string `json:"contact_email,omitempty"`
}
