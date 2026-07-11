from datetime import datetime, timezone

from out import Person


grace = Person(
    date_of_birth=datetime(1906, 12, 9, tzinfo=timezone.utc),
    friends=[],
    name="Grace Hopper",
    contact_email=None,
)

ada = Person(
    date_of_birth=datetime(1815, 12, 10, tzinfo=timezone.utc),
    friends=[grace],
    name="Ada Lovelace",
    contact_email="ada@example.com",
)

dumped = ada.model_dump()

assert dumped["name"] == "Ada Lovelace"
assert dumped["friends"][0]["name"] == "Grace Hopper"
assert dumped["contact_email"] == "ada@example.com"
