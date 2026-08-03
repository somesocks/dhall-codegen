package models

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"math"
	"net"
	"net/url"
	"regexp"
	"strconv"
	"time"
)

type CodecError struct {
	Operation string
	Path string
	Message string
}

func (err CodecError) Error() string {
	return fmt.Sprintf("%s error at %s: %s", err.Operation, err.Path, err.Message)
}

func codecError(operation string, path string, message string) error {
	return CodecError{Operation: operation, Path: path, Message: message}
}

func pathField(path string, field string) string { return path + "." + field }
func pathIndex(path string, index int) string { return fmt.Sprintf("%s[%d]", path, index) }

func asObject(operation string, value any, path string) (error, map[string]any) {
	result, ok := value.(map[string]any)
	if !ok { return codecError(operation, path, "expected object"), nil }
	return nil, result
}

func asArray(operation string, value any, path string) (error, []any) {
	result, ok := value.([]any)
	if !ok { return codecError(operation, path, "expected array"), nil }
	return nil, result
}

func asString(operation string, value any, path string) (error, string) {
	result, ok := value.(string)
	if !ok { return codecError(operation, path, "expected string"), "" }
	return nil, result
}

func numberText(operation string, value any, path string) (error, string) {
	switch number := value.(type) {
	case json.Number:
		if _, err := number.Float64(); err != nil { return codecError(operation, path, "expected number"), "" }
		return nil, string(number)
	case float64:
		if math.IsNaN(number) || math.IsInf(number, 0) { return codecError(operation, path, "expected finite number"), "" }
		return nil, strconv.FormatFloat(number, 'g', -1, 64)
	default:
		return codecError(operation, path, "expected number"), ""
	}
}

func encodeFloat(value float64, path string) (error, any) {
	if math.IsNaN(value) || math.IsInf(value, 0) { return codecError("encode", path, "expected finite number"), nil }
	return nil, json.Number(strconv.FormatFloat(value, 'g', -1, 64))
}

func decodeFloat(value any, path string) (error, float64) {
	err, text := numberText("decode", value, path)
	if err != nil { return err, 0 }
	result, parseErr := strconv.ParseFloat(text, 64)
	if parseErr != nil || math.IsNaN(result) || math.IsInf(result, 0) { return codecError("decode", path, "expected finite number"), 0 }
	return nil, result
}

func encodeInteger(value int, natural bool, path string) (error, any) {
	if natural && value < 0 { return codecError("encode", path, "expected natural number"), nil }
	return nil, json.Number(strconv.Itoa(value))
}

func decodeInteger(value any, natural bool, path string) (error, int) {
	err, text := numberText("decode", value, path)
	if err != nil { return err, 0 }
	result, parseErr := strconv.ParseInt(text, 10, 0)
	if parseErr != nil || (natural && result < 0) { return codecError("decode", path, "expected integer"), 0 }
	return nil, int(result)
}

var emailPattern = regexp.MustCompile(`^[^@\s]+@[^@\s]+\.[^@\s]+$`)
var e164Pattern = regexp.MustCompile(`^\+[1-9][0-9]{1,14}$`)
var uuidPattern = regexp.MustCompile(`(?i)^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$`)

func validateText(variant string, value string, operation string, path string) (error, string) {
	switch variant {
	case "none": return nil, value
	case "email": if !emailPattern.MatchString(value) { return codecError(operation, path, "expected email"), "" }
	case "url": if _, err := url.ParseRequestURI(value); err != nil { return codecError(operation, path, "expected URL"), "" }
	case "base64": if _, err := base64.StdEncoding.DecodeString(value); err != nil { return codecError(operation, path, "expected Base64"), "" }
	case "base64url": if _, err := base64.URLEncoding.DecodeString(value); err != nil { return codecError(operation, path, "expected Base64url"), "" }
	case "e164": if !e164Pattern.MatchString(value) { return codecError(operation, path, "expected E.164 phone number"), "" }
	case "ipv4": if ip := net.ParseIP(value); ip == nil || ip.To4() == nil { return codecError(operation, path, "expected IPv4 address"), "" }
	case "ipv6": if ip := net.ParseIP(value); ip == nil || ip.To4() != nil { return codecError(operation, path, "expected IPv6 address"), "" }
	case "isoDate": if _, err := time.Parse("2006-01-02", value); err != nil { return codecError(operation, path, "expected ISO date"), "" }
	case "isoDateTime": if _, err := time.Parse(time.RFC3339, value); err != nil { return codecError(operation, path, "expected RFC 3339 date-time"), "" }
	case "isoDuration": if len(value) < 2 || value[0] != 'P' { return codecError(operation, path, "expected ISO duration"), "" }
	case "isoTime": if _, err := time.Parse("15:04:05", value); err != nil { return codecError(operation, path, "expected local ISO time"), "" }
	case "uuid": if !uuidPattern.MatchString(value) { return codecError(operation, path, "expected UUID"), "" }
	default:
		if len(variant) > 8 && variant[:8] == "literal:" && value == variant[8:] { return nil, value }
		return codecError(operation, path, "invalid text value"), ""
	}
	return nil, value
}

func encodeText(variant string, value string, path string) (error, any) {
	err, result := validateText(variant, value, "encode", path)
	if err != nil { return err, nil }
	return nil, result
}
func decodeText(variant string, value any, path string) (error, string) {
	err, text := asString("decode", value, path)
	if err != nil { return err, "" }
	return validateText(variant, text, "decode", path)
}

func encodeBoolean(value bool, path string) (error, any) { return nil, value }
func decodeBoolean(value any, path string) (error, bool) {
	result, ok := value.(bool)
	if !ok { return codecError("decode", path, "expected boolean"), false }
	return nil, result
}

func validateAny(operation string, value any, path string) (error, any) {
	switch typed := value.(type) {
	case nil, bool, string: return nil, value
	case float64, json.Number:
		if err, _ := numberText(operation, value, path); err != nil { return err, nil }
		return nil, value
	case []any:
		for index, entry := range typed { if err, _ := validateAny(operation, entry, pathIndex(path, index)); err != nil { return err, nil } }
		return nil, value
	case map[string]any:
		for key, entry := range typed { if err, _ := validateAny(operation, entry, pathField(path, key)); err != nil { return err, nil } }
		return nil, value
	default: return codecError(operation, path, "expected JSON value"), nil
	}
}

func encodeInstant(value time.Time, path string) (error, any) { return nil, value.Format(time.RFC3339Nano) }
func decodeInstant(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse(time.RFC3339, text); if parseErr != nil { return codecError("decode", path, "expected RFC 3339 date-time"), time.Time{} }
	return nil, result
}
func encodeDate(value time.Time, path string) (error, any) { return nil, value.Format("2006-01-02") }
func decodeDate(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse("2006-01-02", text); if parseErr != nil { return codecError("decode", path, "expected ISO date"), time.Time{} }
	return nil, result
}
func encodeLocalTime(value time.Time, path string) (error, any) { return nil, value.Format("15:04:05.999999999") }
func decodeLocalTime(value any, path string) (error, time.Time) {
	err, text := asString("decode", value, path); if err != nil { return err, time.Time{} }
	result, parseErr := time.Parse("15:04:05", text); if parseErr != nil { return codecError("decode", path, "expected local ISO time"), time.Time{} }
	return nil, result
}
func encodeDuration(value string, path string) (error, any) { return encodeText("isoDuration", value, path) }
func decodeDuration(value any, path string) (error, string) { return decodeText("isoDuration", value, path) }





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




func EncodePersonContact(value PersonContact) (err error, result any) {
	return encodePersonContactAt(value, "$")
}

func encodePersonContactAt(value PersonContact, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		{
			var encodedField any
			err, encodedField = encodeText("e164", (struct {
				PhoneNumber string `json:"phone_number"`
				Email *string `json:"email,omitempty"`
			})(value).PhoneNumber, pathField(path, "phone_number"))
			if err != nil {
				return err, result
			}
			encodedObject["phone_number"] = encodedField
		}
		if (struct {
			PhoneNumber string `json:"phone_number"`
			Email *string `json:"email,omitempty"`
		})(value).Email != nil {
			var encodedField any
			err, encodedField = encodeText("email", *(struct {
				PhoneNumber string `json:"phone_number"`
				Email *string `json:"email,omitempty"`
			})(value).Email, pathField(path, "email"))
			if err != nil {
				return err, result
			}
			encodedObject["email"] = encodedField
		}
		result = encodedObject
	}
	return nil, result
}

func DecodePersonContact(input any) (err error, result PersonContact) {
	return decodePersonContactAt(input, "$")
}

func decodePersonContactAt(input any, path string) (err error, result PersonContact) {
	var decoded struct {
		PhoneNumber string `json:"phone_number"`
		Email *string `json:"email,omitempty"`
	}
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["phone_number"]
			if !exists {
				err = codecError("decode", pathField(path, "phone_number"), "missing required field")
				return err, result
			}
			err, decoded.PhoneNumber = decodeText("e164", rawValue, pathField(path, "phone_number"))
			if err != nil {
				return err, result
			}
		}
		if rawValue, exists := object["email"]; exists && rawValue != nil {
			var decodedValue string
			err, decodedValue = decodeText("email", rawValue, pathField(path, "email"))
			if err != nil {
				return err, result
			}
			decoded.Email = &decodedValue
		}
	}
	result = PersonContact(decoded)
	return nil, result
}



func EncodePerson(value Person) (err error, result any) {
	return encodePersonAt(value, "$")
}

func encodePersonAt(value Person, path string) (err error, result any) {
	{
		encodedObject := make(map[string]any)
		{
			var encodedField any
			err, encodedField = encodeLocalTime((struct {
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
			})(value).AppointmentTime, pathField(path, "appointment_time"))
			if err != nil {
				return err, result
			}
			encodedObject["appointment_time"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("base64", (struct {
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
			})(value).BinaryData, pathField(path, "binary_data"))
			if err != nil {
				return err, result
			}
			encodedObject["binary_data"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("isoDate", (struct {
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
			})(value).BirthDate, pathField(path, "birth_date"))
			if err != nil {
				return err, result
			}
			encodedObject["birth_date"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodePersonContactAt((struct {
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
			})(value).Contact, pathField(path, "contact"))
			if err != nil {
				return err, result
			}
			encodedObject["contact"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("isoDateTime", (struct {
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
			})(value).CreatedAt, pathField(path, "created_at"))
			if err != nil {
				return err, result
			}
			encodedObject["created_at"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeDate((struct {
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
			})(value).DateOfBirth, pathField(path, "date_of_birth"))
			if err != nil {
				return err, result
			}
			encodedObject["date_of_birth"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("ipv6", (struct {
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
			})(value).DestinationIp, pathField(path, "destination_ip"))
			if err != nil {
				return err, result
			}
			encodedObject["destination_ip"] = encodedField
		}
		{
			var encodedField any
			{
				entries := (struct {
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
				})(value).Friends
				encodedValues := make([]any, len(entries))
				for index, entry := range entries {
					entryPath := pathIndex(pathField(path, "friends"), index)
					var encodedEntry any
					err, encodedEntry = encodePersonAt(entry, entryPath)
					if err != nil {
						return err, result
					}
					encodedValues[index] = encodedEntry
				}
				encodedField = encodedValues
			}
			encodedObject["friends"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("uuid", (struct {
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
			})(value).Id, pathField(path, "id"))
			if err != nil {
				return err, result
			}
			encodedObject["id"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("none", (struct {
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
			})(value).Name, pathField(path, "name"))
			if err != nil {
				return err, result
			}
			encodedObject["name"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeDuration((struct {
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
			})(value).RetentionPeriod, pathField(path, "retention_period"))
			if err != nil {
				return err, result
			}
			encodedObject["retention_period"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("ipv4", (struct {
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
			})(value).SourceIp, pathField(path, "source_ip"))
			if err != nil {
				return err, result
			}
			encodedObject["source_ip"] = encodedField
		}
		{
			var encodedField any
			err, encodedField = encodeText("base64url", (struct {
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
			})(value).Token, pathField(path, "token"))
			if err != nil {
				return err, result
			}
			encodedObject["token"] = encodedField
		}
		result = encodedObject
	}
	return nil, result
}

func DecodePerson(input any) (err error, result Person) {
	return decodePersonAt(input, "$")
}

func decodePersonAt(input any, path string) (err error, result Person) {
	var decoded struct {
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
	{
		err, object := asObject("decode", input, path)
		if err != nil {
			return err, result
		}
		{
			rawValue, exists := object["appointment_time"]
			if !exists {
				err = codecError("decode", pathField(path, "appointment_time"), "missing required field")
				return err, result
			}
			err, decoded.AppointmentTime = decodeLocalTime(rawValue, pathField(path, "appointment_time"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["binary_data"]
			if !exists {
				err = codecError("decode", pathField(path, "binary_data"), "missing required field")
				return err, result
			}
			err, decoded.BinaryData = decodeText("base64", rawValue, pathField(path, "binary_data"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["birth_date"]
			if !exists {
				err = codecError("decode", pathField(path, "birth_date"), "missing required field")
				return err, result
			}
			err, decoded.BirthDate = decodeText("isoDate", rawValue, pathField(path, "birth_date"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["contact"]
			if !exists {
				err = codecError("decode", pathField(path, "contact"), "missing required field")
				return err, result
			}
			err, decoded.Contact = decodePersonContactAt(rawValue, pathField(path, "contact"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["created_at"]
			if !exists {
				err = codecError("decode", pathField(path, "created_at"), "missing required field")
				return err, result
			}
			err, decoded.CreatedAt = decodeText("isoDateTime", rawValue, pathField(path, "created_at"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["date_of_birth"]
			if !exists {
				err = codecError("decode", pathField(path, "date_of_birth"), "missing required field")
				return err, result
			}
			err, decoded.DateOfBirth = decodeDate(rawValue, pathField(path, "date_of_birth"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["destination_ip"]
			if !exists {
				err = codecError("decode", pathField(path, "destination_ip"), "missing required field")
				return err, result
			}
			err, decoded.DestinationIp = decodeText("ipv6", rawValue, pathField(path, "destination_ip"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["friends"]
			if !exists {
				err = codecError("decode", pathField(path, "friends"), "missing required field")
				return err, result
			}
			{
				err, entries := asArray("decode", rawValue, pathField(path, "friends"))
				if err != nil {
					return err, result
				}
				decodedValues := make([]Person, len(entries))
				for index := range entries {
					entryPath := pathIndex(pathField(path, "friends"), index)
					var decodedEntry Person
					err, decodedEntry = decodePersonAt(entries[index], entryPath)
					if err != nil {
						return err, result
					}
					decodedValues[index] = decodedEntry
				}
				decoded.Friends = decodedValues
			}
		}
		{
			rawValue, exists := object["id"]
			if !exists {
				err = codecError("decode", pathField(path, "id"), "missing required field")
				return err, result
			}
			err, decoded.Id = decodeText("uuid", rawValue, pathField(path, "id"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["name"]
			if !exists {
				err = codecError("decode", pathField(path, "name"), "missing required field")
				return err, result
			}
			err, decoded.Name = decodeText("none", rawValue, pathField(path, "name"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["retention_period"]
			if !exists {
				err = codecError("decode", pathField(path, "retention_period"), "missing required field")
				return err, result
			}
			err, decoded.RetentionPeriod = decodeDuration(rawValue, pathField(path, "retention_period"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["source_ip"]
			if !exists {
				err = codecError("decode", pathField(path, "source_ip"), "missing required field")
				return err, result
			}
			err, decoded.SourceIp = decodeText("ipv4", rawValue, pathField(path, "source_ip"))
			if err != nil {
				return err, result
			}
		}
		{
			rawValue, exists := object["token"]
			if !exists {
				err = codecError("decode", pathField(path, "token"), "missing required field")
				return err, result
			}
			err, decoded.Token = decodeText("base64url", rawValue, pathField(path, "token"))
			if err != nil {
				return err, result
			}
		}
	}
	result = Person(decoded)
	return nil, result
}