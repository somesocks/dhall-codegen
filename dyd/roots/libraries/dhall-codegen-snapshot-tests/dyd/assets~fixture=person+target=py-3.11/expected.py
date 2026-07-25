from __future__ import annotations

from collections.abc import Awaitable, Callable
from datetime import datetime
from typing import Annotated, Any, Literal, Protocol, TypeAlias

from pydantic import BaseModel, TypeAdapter

# used to simulate intersection type
def _check_all_of(*adapters: TypeAdapter[Any]):
    def check(v: Any) -> Any:
        for ta in adapters:
            ta.validate_python(v)  # raises on failure
        return v
    return check


class Person(BaseModel):
    appointment_time : str
    birth_date : str
    created_at : str
    date_of_birth : datetime
    destination_ip : str
    friends : list[Person]
    id : str
    name : str
    retention_period : str
    source_ip : str
    contact_email : (str) | None