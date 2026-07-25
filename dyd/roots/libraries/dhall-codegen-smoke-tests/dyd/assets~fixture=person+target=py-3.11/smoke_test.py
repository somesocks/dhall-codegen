from datetime import datetime, timezone

from out import Person


grace = Person(
    birth_date="1906-12-09",
    date_of_birth=datetime(1906, 12, 9, tzinfo=timezone.utc),
    friends=[],
    name="Grace Hopper",
    contact_email=None,
    created_at="1906-12-09T00:00:00Z",
)

ada = Person(
    birth_date="1815-12-10",
    date_of_birth=datetime(1815, 12, 10, tzinfo=timezone.utc),
    friends=[grace],
    name="Ada Lovelace",
    contact_email="ada@example.com",
    created_at="1815-12-10T00:00:00Z",
)

dumped = ada.model_dump()

assert dumped["name"] == "Ada Lovelace"
assert dumped["friends"][0]["name"] == "Grace Hopper"
assert dumped["contact_email"] == "ada@example.com"
assert dumped["created_at"] == "1815-12-10T00:00:00Z"
assert dumped["birth_date"] == "1815-12-10"
