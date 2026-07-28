from datetime import date, time

from out import CodecError, Person, PersonContact, decode_Person, encode_Person


def expect_codec_error(operation):
    try:
        operation()
    except CodecError:
        return
    raise AssertionError("expected CodecError")


grace = Person(
    appointment_time=time(9, 0),
    binary_data="+/8=",
    birth_date="1906-12-09",
    contact=PersonContact(phone_number="+442079460123", email=None),
    date_of_birth=date(1906, 12, 9),
    friends=[],
    id="123e4567-e89b-42d3-a456-426614174001",
    name="Grace Hopper",
    retention_period="P2W",
    source_ip="198.51.100.2",
    destination_ip="2001:db8::2",
    token="-_8=",
    created_at="1906-12-09T00:00:00Z",
)

ada = Person(
    appointment_time=time(14, 30, 0, 123000),
    binary_data="+/8=",
    birth_date="1815-12-10",
    contact=PersonContact(phone_number="+14155552671", email="ada@example.com"),
    date_of_birth=date(1815, 12, 10),
    friends=[grace],
    id="123e4567-e89b-42d3-a456-426614174000",
    name="Ada Lovelace",
    retention_period="P1Y2M3DT4H5M6S",
    source_ip="192.0.2.1",
    destination_ip="2001:db8::1",
    token="-_8=",
    created_at="1815-12-10T00:00:00Z",
)

encoded = encode_Person(ada)
assert encoded["name"] == "Ada Lovelace"
assert encoded["friends"][0]["name"] == "Grace Hopper"
assert encoded["appointment_time"] == "14:30:00.123000"
assert encoded["binary_data"] == "+/8="
assert encoded["birth_date"] == "1815-12-10"
assert encoded["contact"] == {"phone_number": "+14155552671", "email": "ada@example.com"}
assert encoded["created_at"] == "1815-12-10T00:00:00Z"
assert encoded["date_of_birth"] == "1815-12-10"
assert encoded["destination_ip"] == "2001:db8::1"
assert encoded["id"] == "123e4567-e89b-42d3-a456-426614174000"
assert encoded["retention_period"] == "P1Y2M3DT4H5M6S"
assert encoded["source_ip"] == "192.0.2.1"
assert encoded["token"] == "-_8="
assert encoded["friends"][0]["contact"] == {"phone_number": "+442079460123"}

decoded = decode_Person(encoded)
assert decoded.name == "Ada Lovelace"
assert decoded.friends[0].name == "Grace Hopper"
assert decoded.contact.email == "ada@example.com"
assert decoded.appointment_time == time(14, 30, 0, 123000)
assert decoded.date_of_birth == date(1815, 12, 10)
assert decoded.destination_ip == "2001:db8::1"
assert decoded.friends[0].contact.email is None

expect_codec_error(lambda: decode_Person({"name": "Ada"}))
expect_codec_error(lambda: decode_Person({**encoded, "binary_data": "not-base64"}))
expect_codec_error(lambda: decode_Person({**encoded, "contact": {"phone_number": "14155552671"}}))
expect_codec_error(lambda: decode_Person({**encoded, "friends": [{"name": "Grace"}]}))
expect_codec_error(lambda: encode_Person(ada.model_copy(update={"source_ip": "999.0.0.1"})))
