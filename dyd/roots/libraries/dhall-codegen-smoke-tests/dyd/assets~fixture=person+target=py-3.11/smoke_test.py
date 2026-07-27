from datetime import date, time

from out import Person, PersonContact


grace = Person(
    appointment_time=time(9, 0),
    binary_data="+/8",
    birth_date="1906-12-09",
    contact=PersonContact(phone_number="+442079460123", email=None),
    date_of_birth=date(1906, 12, 9),
    friends=[],
    id="123e4567-e89b-42d3-a456-426614174001",
    name="Grace Hopper",
    retention_period="P2W",
    source_ip="198.51.100.2",
    destination_ip="2001:db8::2",
    token="-_8",
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

dumped = ada.model_dump()

assert dumped["name"] == "Ada Lovelace"
assert dumped["friends"][0]["name"] == "Grace Hopper"
assert dumped["contact"]["email"] == "ada@example.com"
assert dumped["date_of_birth"] == date(1815, 12, 10)
assert dumped["created_at"] == "1815-12-10T00:00:00Z"
assert dumped["birth_date"] == "1815-12-10"
assert dumped["appointment_time"] == time(14, 30, 0, 123000)
assert dumped["retention_period"] == "P1Y2M3DT4H5M6S"
assert dumped["id"] == "123e4567-e89b-42d3-a456-426614174000"
assert dumped["contact"]["phone_number"] == "+14155552671"
assert dumped["source_ip"] == "192.0.2.1"
assert dumped["destination_ip"] == "2001:db8::1"
assert dumped["binary_data"] == "+/8="
assert dumped["token"] == "-_8="
