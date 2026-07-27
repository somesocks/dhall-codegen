from __future__ import annotations

from datetime import date, datetime, time
from pydantic import BaseModel, Field, TypeAdapter
from typing import (
    Any, Optional, Union, List, Set, Dict, Tuple, Callable, Literal
)

# backports for 3.8:
from typing_extensions import Annotated, Protocol  # for constraints/validators

try:
    from typing_extensions import TypeAlias
except Exception:
    TypeAlias = Any  # fall back; plain assignment still works

try:
    from types import NoneType          # 3.10+
except ImportError:
    NoneType = type(None)               # fallback for 3.8–3.9

# used to simulate intersection type
def _check_all_of(*adapters: TypeAdapter[Any]):
    def check(v: Any) -> Any:
        for ta in adapters:
            ta.validate_python(v)  # raises on failure
        return v
    return check


class PersonContact(BaseModel):# contact details
    phone_number : str
    email : Optional[str]

class Person(BaseModel):
    appointment_time : time
    binary_data : str
    birth_date : str
    contact : PersonContact
    created_at : str
    date_of_birth : date
    destination_ip : str
    friends : List[Person]
    id : str
    name : str
    retention_period : str
    source_ip : str
    token : str