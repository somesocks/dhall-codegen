package models

import "time"

type PersonContact struct {
	PhoneNumber string `json:"phone_number"`
	Email *string `json:"email,omitempty"`
}

type Person struct {
	AppointmentTime time.Time `json:"appointment_time"`
	BinaryData string `json:"binary_data"`
	BirthDate string `json:"birth_date"`
	Contact PersonContact `json:"contact"`
	CreatedAt string `json:"created_at"`
	DateOfBirth time.Time `json:"date_of_birth"`
	DestinationIp string `json:"destination_ip"`
	Friends []Person `json:"friends"`
	Id string `json:"id"`
	Name string `json:"name"`
	RetentionPeriod string `json:"retention_period"`
	SourceIp string `json:"source_ip"`
	Token string `json:"token"`
}
