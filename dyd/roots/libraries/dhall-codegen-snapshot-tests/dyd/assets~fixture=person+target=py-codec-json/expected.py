from __future__ import annotations

from collections.abc import Awaitable, Callable
from datetime import date, datetime, time
from typing import Annotated, Any, Literal, Protocol, TypeAlias

from pydantic import BaseModel, TypeAdapter

# used to simulate intersection type
def _check_all_of(*adapters: TypeAdapter[Any]):
    def check(v: Any) -> Any:
        for ta in adapters:
            ta.validate_python(v)  # raises on failure
        return v
    return check


class PersonContact(BaseModel):# contact details
    phone_number : str
    email : (str) | None

class Person(BaseModel):
    appointment_time : time
    binary_data : str
    birth_date : str
    contact : PersonContact
    created_at : str
    date_of_birth : date
    destination_ip : str
    friends : list[Person]
    id : str
    name : str
    retention_period : str
    source_ip : str
    token : str

import base64
import math
import re
from datetime import date, datetime, time
from ipaddress import IPv4Address, IPv6Address, ip_address
from typing import Any
from urllib.parse import urlparse
from uuid import UUID


class CodecError(ValueError):
    def __init__(self, operation: str, path: str, message: str):
        super().__init__(f"{operation} error at {path}: {message}")
        self.operation = operation
        self.path = path
        self.message = message


def _fail(operation: str, path: str, message: str) -> None:
    raise CodecError(operation, path, message)


def _field(path: str, name: str) -> str:
    return f"{path}.{name}"


def _index(path: str, index: int) -> str:
    return f"{path}[{index}]"


def _object(operation: str, value: Any, path: str) -> dict[str, Any]:
    if not isinstance(value, dict) or any(not isinstance(key, str) for key in value):
        _fail(operation, path, "expected object")
    return value


def _array(operation: str, value: Any, path: str) -> list[Any]:
    if not isinstance(value, list):
        _fail(operation, path, "expected array")
    return value


def _string(operation: str, value: Any, path: str) -> str:
    if not isinstance(value, str):
        _fail(operation, path, "expected string")
    return value


def _number(operation: str, value: Any, path: str, kind: str) -> int | float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        _fail(operation, path, "expected number")
    if not math.isfinite(value):
        _fail(operation, path, "expected finite number")
    if kind in ("natural", "integer") and not isinstance(value, int):
        _fail(operation, path, "expected integer")
    if kind == "natural" and value < 0:
        _fail(operation, path, "expected natural number")
    return value


def _text(operation: str, value: Any, path: str, variant: str) -> str:
    value = _string(operation, value, path)
    if variant == "none":
        return value
    if variant == "email" and re.fullmatch(r"[^@\s]+@[^@\s]+\.[^@\s]+", value):
        return value
    if variant == "url":
        parsed = urlparse(value)
        if parsed.scheme and parsed.netloc:
            return value
    if variant == "base64":
        try:
            base64.b64decode(value, validate=True)
            return value
        except ValueError:
            pass
    if variant == "base64url":
        try:
            if re.fullmatch(r"[A-Za-z0-9_-]*={0,2}", value):
                base64.b64decode(value, altchars=b"-_", validate=True)
                return value
        except ValueError:
            pass
    if variant == "e164" and re.fullmatch(r"\+[1-9][0-9]{1,14}", value):
        return value
    if variant == "ipv4":
        try:
            if isinstance(ip_address(value), IPv4Address):
                return value
        except ValueError:
            pass
    if variant == "ipv6":
        try:
            if isinstance(ip_address(value), IPv6Address):
                return value
        except ValueError:
            pass
    if variant == "isoDate":
        try:
            date.fromisoformat(value)
            return value
        except ValueError:
            pass
    if variant == "isoDateTime":
        try:
            datetime.fromisoformat(value.replace("Z", "+00:00"))
            return value
        except ValueError:
            pass
    if variant == "isoTime":
        try:
            time.fromisoformat(value)
            return value
        except ValueError:
            pass
    if variant == "isoDuration" and re.fullmatch(r"P(?=\d|T\d)(?:\d+Y)?(?:\d+M)?(?:\d+W)?(?:\d+D)?(?:T(?:\d+H)?(?:\d+M)?(?:\d+(?:\.\d+)?S)?)?", value):
        return value
    if variant == "uuid":
        try:
            UUID(value)
            return value
        except ValueError:
            pass
    if variant.startswith("literal:") and value == variant[8:]:
        return value
    _fail(operation, path, f"invalid {variant} text")


def _any(operation: str, value: Any, path: str) -> Any:
    if value is None or isinstance(value, (bool, str)):
        return value
    if isinstance(value, (int, float)) and not isinstance(value, bool):
        return _number(operation, value, path, "none")
    if isinstance(value, list):
        for index, item in enumerate(value):
            _any(operation, item, _index(path, index))
        return value
    if isinstance(value, dict) and all(isinstance(key, str) for key in value):
        for key, item in value.items():
            _any(operation, item, _field(path, key))
        return value
    _fail(operation, path, "expected JSON value")


def _time(operation: str, value: Any, path: str, variant: str) -> Any:
    if variant == "none":
        if operation == "encode":
            if not isinstance(value, datetime): _fail(operation, path, "expected datetime")
            return value.isoformat()
        try:
            return datetime.fromisoformat(_string(operation, value, path).replace("Z", "+00:00"))
        except ValueError:
            _fail(operation, path, "expected ISO date-time")
    if variant == "date":
        if operation == "encode":
            if not isinstance(value, date) or isinstance(value, datetime): _fail(operation, path, "expected date")
            return value.isoformat()
        try:
            return date.fromisoformat(_string(operation, value, path))
        except ValueError:
            _fail(operation, path, "expected ISO date")
    if variant == "time":
        if operation == "encode":
            if not isinstance(value, time): _fail(operation, path, "expected time")
            return value.isoformat()
        try:
            return time.fromisoformat(_string(operation, value, path))
        except ValueError:
            _fail(operation, path, "expected ISO time")
    return _text(operation, value, path, "isoDuration")



def _encode_PersonContact_at(value: PersonContact, path: str) -> Any:
    result = {}
    result["phone_number"] = None
    result["phone_number"] = _text("encode", value.phone_number, _field(path, "phone_number"), "e164")
    if value.email is not None:
        result["email"] = _text("encode", value.email, _field(path, "email"), "email")
    return result

def _decode_PersonContact_at(input: Any, path: str) -> PersonContact:
    object = _object("decode", input, path)
    result = {}
    if "phone_number" not in object:
        _fail("decode", _field(path, "phone_number"), "missing required field")
    result["phone_number"] = _text("decode", object["phone_number"], _field(path, "phone_number"), "e164")
    if "email" in object:
        result["email"] = _text("decode", object["email"], _field(path, "email"), "email")
    else:
        result["email"] = None
    return PersonContact.model_construct(**result)

def encode_PersonContact(value: PersonContact) -> Any:
    return _encode_PersonContact_at(value, "$")

def decode_PersonContact(input: Any) -> PersonContact:
    return _decode_PersonContact_at(input, "$")


def _encode_Person_at(value: Person, path: str) -> Any:
    result = {}
    result["appointment_time"] = None
    result["appointment_time"] = _time("encode", value.appointment_time, _field(path, "appointment_time"), "time")
    result["binary_data"] = None
    result["binary_data"] = _text("encode", value.binary_data, _field(path, "binary_data"), "base64")
    result["birth_date"] = None
    result["birth_date"] = _text("encode", value.birth_date, _field(path, "birth_date"), "isoDate")
    result["contact"] = None
    result["contact"] = _encode_PersonContact_at(value.contact, _field(path, "contact"))
    result["created_at"] = None
    result["created_at"] = _text("encode", value.created_at, _field(path, "created_at"), "isoDateTime")
    result["date_of_birth"] = None
    result["date_of_birth"] = _time("encode", value.date_of_birth, _field(path, "date_of_birth"), "date")
    result["destination_ip"] = None
    result["destination_ip"] = _text("encode", value.destination_ip, _field(path, "destination_ip"), "ipv6")
    result["friends"] = None
    if not isinstance(value.friends, list):
        _fail("encode", _field(path, "friends"), "expected list")
    result["friends"] = []
    for index, entry in enumerate(value.friends):
        converted_Personx = _encode_Person_at(entry, _index(_field(path, "friends"), index))
        result["friends"].append(converted_Personx)
    result["id"] = None
    result["id"] = _text("encode", value.id, _field(path, "id"), "uuid")
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    result["retention_period"] = None
    result["retention_period"] = _time("encode", value.retention_period, _field(path, "retention_period"), "duration")
    result["source_ip"] = None
    result["source_ip"] = _text("encode", value.source_ip, _field(path, "source_ip"), "ipv4")
    result["token"] = None
    result["token"] = _text("encode", value.token, _field(path, "token"), "base64url")
    return result

def _decode_Person_at(input: Any, path: str) -> Person:
    object = _object("decode", input, path)
    result = {}
    if "appointment_time" not in object:
        _fail("decode", _field(path, "appointment_time"), "missing required field")
    result["appointment_time"] = _time("decode", object["appointment_time"], _field(path, "appointment_time"), "time")
    if "binary_data" not in object:
        _fail("decode", _field(path, "binary_data"), "missing required field")
    result["binary_data"] = _text("decode", object["binary_data"], _field(path, "binary_data"), "base64")
    if "birth_date" not in object:
        _fail("decode", _field(path, "birth_date"), "missing required field")
    result["birth_date"] = _text("decode", object["birth_date"], _field(path, "birth_date"), "isoDate")
    if "contact" not in object:
        _fail("decode", _field(path, "contact"), "missing required field")
    result["contact"] = _decode_PersonContact_at(object["contact"], _field(path, "contact"))
    if "created_at" not in object:
        _fail("decode", _field(path, "created_at"), "missing required field")
    result["created_at"] = _text("decode", object["created_at"], _field(path, "created_at"), "isoDateTime")
    if "date_of_birth" not in object:
        _fail("decode", _field(path, "date_of_birth"), "missing required field")
    result["date_of_birth"] = _time("decode", object["date_of_birth"], _field(path, "date_of_birth"), "date")
    if "destination_ip" not in object:
        _fail("decode", _field(path, "destination_ip"), "missing required field")
    result["destination_ip"] = _text("decode", object["destination_ip"], _field(path, "destination_ip"), "ipv6")
    if "friends" not in object:
        _fail("decode", _field(path, "friends"), "missing required field")
    result["friends"] = []
    for index, entry in enumerate(_array("decode", object["friends"], _field(path, "friends"))):
        converted_Personx = _decode_Person_at(entry, _index(_field(path, "friends"), index))
        result["friends"].append(converted_Personx)
    if "id" not in object:
        _fail("decode", _field(path, "id"), "missing required field")
    result["id"] = _text("decode", object["id"], _field(path, "id"), "uuid")
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    if "retention_period" not in object:
        _fail("decode", _field(path, "retention_period"), "missing required field")
    result["retention_period"] = _time("decode", object["retention_period"], _field(path, "retention_period"), "duration")
    if "source_ip" not in object:
        _fail("decode", _field(path, "source_ip"), "missing required field")
    result["source_ip"] = _text("decode", object["source_ip"], _field(path, "source_ip"), "ipv4")
    if "token" not in object:
        _fail("decode", _field(path, "token"), "missing required field")
    result["token"] = _text("decode", object["token"], _field(path, "token"), "base64url")
    return Person.model_construct(**result)

def encode_Person(value: Person) -> Any:
    return _encode_Person_at(value, "$")

def decode_Person(input: Any) -> Person:
    return _decode_Person_at(input, "$")