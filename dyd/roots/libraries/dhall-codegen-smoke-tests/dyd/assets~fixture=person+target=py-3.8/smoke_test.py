from datetime import datetime, timezone

from out import Person


grace = Person(
    appointment_time="09:00:00Z",
    birth_date="1906-12-09",
    date_of_birth=datetime(1906, 12, 9, tzinfo=timezone.utc),
    friends=[],
    id="123e4567-e89b-42d3-a456-426614174001",
    name="Grace Hopper",
    retention_period="P2W",
    contact_email=None,
    created_at="1906-12-09T00:00:00Z",
)

ada = Person(
    appointment_time="14:30:00.123+02:00",
    birth_date="1815-12-10",
    date_of_birth=datetime(1815, 12, 10, tzinfo=timezone.utc),
    friends=[grace],
    id="123e4567-e89b-42d3-a456-426614174000",
    name="Ada Lovelace",
    retention_period="P1Y2M3DT4H5M6S",
    contact_email="ada@example.com",
    created_at="1815-12-10T00:00:00Z",
)

dumped = ada.model_dump()

assert dumped["name"] == "Ada Lovelace"
assert dumped["friends"][0]["name"] == "Grace Hopper"
assert dumped["contact_email"] == "ada@example.com"
assert dumped["created_at"] == "1815-12-10T00:00:00Z"
assert dumped["birth_date"] == "1815-12-10"
assert dumped["appointment_time"] == "14:30:00.123+02:00"
assert dumped["retention_period"] == "P1Y2M3DT4H5M6S"
assert dumped["id"] == "123e4567-e89b-42d3-a456-426614174000"
