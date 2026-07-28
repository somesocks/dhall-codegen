let prelude = ''
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
''

in  prelude
