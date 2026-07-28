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


Foo: TypeAlias = str

Bar: TypeAlias = int

# boolean test 0
BooleanTest0: TypeAlias = bool

# boolean test 1
BooleanTest1: TypeAlias = bool

# boolean test 2
BooleanTest2: TypeAlias = bool

# number test 0
NumberTest0: TypeAlias = float

# number test 1
NumberTest1: TypeAlias = float

# number test 2
NumberTest2: TypeAlias = int

# number test 3
NumberTest3: TypeAlias = int

# number test 4
NumberTest4: TypeAlias = float

# text test 0
TextTest0: TypeAlias = str

# text test 1
TextTest1: TypeAlias = str

# text test 2
TextTest2: TypeAlias = str

# text test 3
TextTest3: TypeAlias = str

# text test 4
TextTest4: TypeAlias = Literal['foo']

# text test 5
TextTest5: TypeAlias = str

# text test 6
TextTest6: TypeAlias = str

# text test 7
TextTest7: TypeAlias = str

# text test 8
TextTest8: TypeAlias = str

# text test 9
TextTest9: TypeAlias = str

# text test 10
TextTest10: TypeAlias = str

# text test 11
TextTest11: TypeAlias = str

# text test 12
TextTest12: TypeAlias = str

# text test 13
TextTest13: TypeAlias = str

# text test 14
TextTest14: TypeAlias = str

# optional test 0
OptionalTest0: TypeAlias = (str) | None

class OptionalTest1Value(BaseModel):
    foo : str

# optional test 1
OptionalTest1: TypeAlias = (OptionalTest1Value) | None

# optional test 2
OptionalTest2: TypeAlias = (str) | None

# list test 0
ListTest0: TypeAlias = list[str]

# list test 1
ListTest1: TypeAlias = list[list[str]]

class ListTest2Values(BaseModel):# a record inside a list
    foo : str

# list test 2
ListTest2: TypeAlias = list[ListTest2Values]

# tuple test 0
TupleTest0: TypeAlias = tuple[str, int]

# tuple test 1
TupleTest1: TypeAlias = tuple[str, int]

# tuple test 2
TupleTest2: TypeAlias = tuple[str, tuple[str, int]]

# set test 0
SetTest0: TypeAlias = set[str]

# set test 1
SetTest1: TypeAlias = list[str]

# set test 2
SetTest2: TypeAlias = set[set[str]]

class SetTest3Values(BaseModel):# a record inside a set
    foo : str

# set test 3
SetTest3: TypeAlias = set[SetTest3Values]

# map test 0
MapTest0: TypeAlias = dict[str, str]

# map test 1
MapTest1: TypeAlias = dict[str, str]

# map test 2
MapTest2: TypeAlias = dict[str, dict[str, str]]

class MapTest3Keys(BaseModel):# a keys record inside a map
    foo : str

class MapTest3Values(BaseModel):# a values record inside a map
    foo : str

# map test 3
MapTest3: TypeAlias = dict[MapTest3Keys, MapTest3Values]

# record test 0
class RecordTest0(BaseModel):
    age : int
    deceased : bool
    name : str

# record test 1
class RecordTest1(BaseModel):# a record
    age : int
    deceased : bool
    name : str

class RecordTest2Contact(BaseModel):
    email : (str) | None
    phone : (str) | None

# record test 2
class RecordTest2(BaseModel):# a record with an embedded record
    age : int
    contact : RecordTest2Contact
    deceased : bool
    name : str

# record test 3
class RecordTest3(BaseModel):# a record with optional props
    name : str
    age : (int) | None
    deceased : (bool) | None

# record test 4
class RecordTest4(Protocol):
    id : str
    status : str
    age : (int) | None

# time test 0
TimeTest0: TypeAlias = datetime

# time test 1
TimeTest1: TypeAlias = datetime

# time test 2
TimeTest2: TypeAlias = date

# time test 3
TimeTest3: TypeAlias = time

# time test 4
TimeTest4: TypeAlias = str

# any test 0
AnyTest0: TypeAlias = Any

# any test 1
AnyTest1: TypeAlias = Any

# any test 2
AnyTest2: TypeAlias = Any

# any test 3
AnyTest3: TypeAlias = Any

class Person(BaseModel):
    age : int
    deceased : bool
    name : str

People: TypeAlias = list[Person]

# oneOf test 0
OneOfTest0: TypeAlias = (str | int)

# oneOf test 1
OneOfTest1: TypeAlias = (str | int)

class OneOfTest2Option2(BaseModel):
    bar : float
    foo : str

# oneOf test 2
OneOfTest2: TypeAlias = (str | int | OneOfTest2Option2)

# oneOf test 3
OneOfTest3: TypeAlias = (Foo | Bar)

class OneOfTest4Option0(BaseModel):
    bar : float
    foo : str

class OneOfTest4Option1(BaseModel):
    foo : str

# oneOf test 4
OneOfTest4: TypeAlias = (OneOfTest4Option0 | OneOfTest4Option1)

class OneOfTest5Option0(BaseModel):
    foo : str

class OneOfTest5Option1(BaseModel):
    bar : float
    foo : str

# oneOf test 5
OneOfTest5: TypeAlias = (OneOfTest5Option0 | OneOfTest5Option1)

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



def _encode_Foo_at(value: Foo, path: str) -> Any:
    result = _text("encode", value, path, "none")
    return result

def _decode_Foo_at(input: Any, path: str) -> Foo:
    result = _text("decode", input, path, "none")
    return result

def encode_Foo(value: Foo) -> Any:
    return _encode_Foo_at(value, "$")

def decode_Foo(input: Any) -> Foo:
    return _decode_Foo_at(input, "$")


def _encode_Bar_at(value: Bar, path: str) -> Any:
    result = _number("encode", value, path, "natural")
    return result

def _decode_Bar_at(input: Any, path: str) -> Bar:
    result = _number("decode", input, path, "natural")
    return result

def encode_Bar(value: Bar) -> Any:
    return _encode_Bar_at(value, "$")

def decode_Bar(input: Any) -> Bar:
    return _decode_Bar_at(input, "$")


def _encode_BooleanTest0_at(value: BooleanTest0, path: str) -> Any:
    if not isinstance(value, bool):
        _fail("encode", path, "expected boolean")
    result = value
    return result

def _decode_BooleanTest0_at(input: Any, path: str) -> BooleanTest0:
    if not isinstance(input, bool):
        _fail("decode", path, "expected boolean")
    result = input
    return result

def encode_BooleanTest0(value: BooleanTest0) -> Any:
    return _encode_BooleanTest0_at(value, "$")

def decode_BooleanTest0(input: Any) -> BooleanTest0:
    return _decode_BooleanTest0_at(input, "$")


def _encode_BooleanTest1_at(value: BooleanTest1, path: str) -> Any:
    if not isinstance(value, bool):
        _fail("encode", path, "expected boolean")
    result = value
    return result

def _decode_BooleanTest1_at(input: Any, path: str) -> BooleanTest1:
    if not isinstance(input, bool):
        _fail("decode", path, "expected boolean")
    result = input
    return result

def encode_BooleanTest1(value: BooleanTest1) -> Any:
    return _encode_BooleanTest1_at(value, "$")

def decode_BooleanTest1(input: Any) -> BooleanTest1:
    return _decode_BooleanTest1_at(input, "$")


def _encode_BooleanTest2_at(value: BooleanTest2, path: str) -> Any:
    if not isinstance(value, bool):
        _fail("encode", path, "expected boolean")
    result = value
    return result

def _decode_BooleanTest2_at(input: Any, path: str) -> BooleanTest2:
    if not isinstance(input, bool):
        _fail("decode", path, "expected boolean")
    result = input
    return result

def encode_BooleanTest2(value: BooleanTest2) -> Any:
    return _encode_BooleanTest2_at(value, "$")

def decode_BooleanTest2(input: Any) -> BooleanTest2:
    return _decode_BooleanTest2_at(input, "$")


def _encode_NumberTest0_at(value: NumberTest0, path: str) -> Any:
    result = _number("encode", value, path, "none")
    return result

def _decode_NumberTest0_at(input: Any, path: str) -> NumberTest0:
    result = _number("decode", input, path, "none")
    return result

def encode_NumberTest0(value: NumberTest0) -> Any:
    return _encode_NumberTest0_at(value, "$")

def decode_NumberTest0(input: Any) -> NumberTest0:
    return _decode_NumberTest0_at(input, "$")


def _encode_NumberTest1_at(value: NumberTest1, path: str) -> Any:
    result = _number("encode", value, path, "none")
    return result

def _decode_NumberTest1_at(input: Any, path: str) -> NumberTest1:
    result = _number("decode", input, path, "none")
    return result

def encode_NumberTest1(value: NumberTest1) -> Any:
    return _encode_NumberTest1_at(value, "$")

def decode_NumberTest1(input: Any) -> NumberTest1:
    return _decode_NumberTest1_at(input, "$")


def _encode_NumberTest2_at(value: NumberTest2, path: str) -> Any:
    result = _number("encode", value, path, "natural")
    return result

def _decode_NumberTest2_at(input: Any, path: str) -> NumberTest2:
    result = _number("decode", input, path, "natural")
    return result

def encode_NumberTest2(value: NumberTest2) -> Any:
    return _encode_NumberTest2_at(value, "$")

def decode_NumberTest2(input: Any) -> NumberTest2:
    return _decode_NumberTest2_at(input, "$")


def _encode_NumberTest3_at(value: NumberTest3, path: str) -> Any:
    result = _number("encode", value, path, "integer")
    return result

def _decode_NumberTest3_at(input: Any, path: str) -> NumberTest3:
    result = _number("decode", input, path, "integer")
    return result

def encode_NumberTest3(value: NumberTest3) -> Any:
    return _encode_NumberTest3_at(value, "$")

def decode_NumberTest3(input: Any) -> NumberTest3:
    return _decode_NumberTest3_at(input, "$")


def _encode_NumberTest4_at(value: NumberTest4, path: str) -> Any:
    result = _number("encode", value, path, "decimal")
    return result

def _decode_NumberTest4_at(input: Any, path: str) -> NumberTest4:
    result = _number("decode", input, path, "decimal")
    return result

def encode_NumberTest4(value: NumberTest4) -> Any:
    return _encode_NumberTest4_at(value, "$")

def decode_NumberTest4(input: Any) -> NumberTest4:
    return _decode_NumberTest4_at(input, "$")


def _encode_TextTest0_at(value: TextTest0, path: str) -> Any:
    result = _text("encode", value, path, "none")
    return result

def _decode_TextTest0_at(input: Any, path: str) -> TextTest0:
    result = _text("decode", input, path, "none")
    return result

def encode_TextTest0(value: TextTest0) -> Any:
    return _encode_TextTest0_at(value, "$")

def decode_TextTest0(input: Any) -> TextTest0:
    return _decode_TextTest0_at(input, "$")


def _encode_TextTest1_at(value: TextTest1, path: str) -> Any:
    result = _text("encode", value, path, "none")
    return result

def _decode_TextTest1_at(input: Any, path: str) -> TextTest1:
    result = _text("decode", input, path, "none")
    return result

def encode_TextTest1(value: TextTest1) -> Any:
    return _encode_TextTest1_at(value, "$")

def decode_TextTest1(input: Any) -> TextTest1:
    return _decode_TextTest1_at(input, "$")


def _encode_TextTest2_at(value: TextTest2, path: str) -> Any:
    result = _text("encode", value, path, "email")
    return result

def _decode_TextTest2_at(input: Any, path: str) -> TextTest2:
    result = _text("decode", input, path, "email")
    return result

def encode_TextTest2(value: TextTest2) -> Any:
    return _encode_TextTest2_at(value, "$")

def decode_TextTest2(input: Any) -> TextTest2:
    return _decode_TextTest2_at(input, "$")


def _encode_TextTest3_at(value: TextTest3, path: str) -> Any:
    result = _text("encode", value, path, "url")
    return result

def _decode_TextTest3_at(input: Any, path: str) -> TextTest3:
    result = _text("decode", input, path, "url")
    return result

def encode_TextTest3(value: TextTest3) -> Any:
    return _encode_TextTest3_at(value, "$")

def decode_TextTest3(input: Any) -> TextTest3:
    return _decode_TextTest3_at(input, "$")


def _encode_TextTest4_at(value: TextTest4, path: str) -> Any:
    result = _text("encode", value, path, "literal:foo")
    return result

def _decode_TextTest4_at(input: Any, path: str) -> TextTest4:
    result = _text("decode", input, path, "literal:foo")
    return result

def encode_TextTest4(value: TextTest4) -> Any:
    return _encode_TextTest4_at(value, "$")

def decode_TextTest4(input: Any) -> TextTest4:
    return _decode_TextTest4_at(input, "$")


def _encode_TextTest5_at(value: TextTest5, path: str) -> Any:
    result = _text("encode", value, path, "isoDateTime")
    return result

def _decode_TextTest5_at(input: Any, path: str) -> TextTest5:
    result = _text("decode", input, path, "isoDateTime")
    return result

def encode_TextTest5(value: TextTest5) -> Any:
    return _encode_TextTest5_at(value, "$")

def decode_TextTest5(input: Any) -> TextTest5:
    return _decode_TextTest5_at(input, "$")


def _encode_TextTest6_at(value: TextTest6, path: str) -> Any:
    result = _text("encode", value, path, "isoDate")
    return result

def _decode_TextTest6_at(input: Any, path: str) -> TextTest6:
    result = _text("decode", input, path, "isoDate")
    return result

def encode_TextTest6(value: TextTest6) -> Any:
    return _encode_TextTest6_at(value, "$")

def decode_TextTest6(input: Any) -> TextTest6:
    return _decode_TextTest6_at(input, "$")


def _encode_TextTest7_at(value: TextTest7, path: str) -> Any:
    result = _text("encode", value, path, "isoTime")
    return result

def _decode_TextTest7_at(input: Any, path: str) -> TextTest7:
    result = _text("decode", input, path, "isoTime")
    return result

def encode_TextTest7(value: TextTest7) -> Any:
    return _encode_TextTest7_at(value, "$")

def decode_TextTest7(input: Any) -> TextTest7:
    return _decode_TextTest7_at(input, "$")


def _encode_TextTest8_at(value: TextTest8, path: str) -> Any:
    result = _text("encode", value, path, "isoDuration")
    return result

def _decode_TextTest8_at(input: Any, path: str) -> TextTest8:
    result = _text("decode", input, path, "isoDuration")
    return result

def encode_TextTest8(value: TextTest8) -> Any:
    return _encode_TextTest8_at(value, "$")

def decode_TextTest8(input: Any) -> TextTest8:
    return _decode_TextTest8_at(input, "$")


def _encode_TextTest9_at(value: TextTest9, path: str) -> Any:
    result = _text("encode", value, path, "uuid")
    return result

def _decode_TextTest9_at(input: Any, path: str) -> TextTest9:
    result = _text("decode", input, path, "uuid")
    return result

def encode_TextTest9(value: TextTest9) -> Any:
    return _encode_TextTest9_at(value, "$")

def decode_TextTest9(input: Any) -> TextTest9:
    return _decode_TextTest9_at(input, "$")


def _encode_TextTest10_at(value: TextTest10, path: str) -> Any:
    result = _text("encode", value, path, "ipv4")
    return result

def _decode_TextTest10_at(input: Any, path: str) -> TextTest10:
    result = _text("decode", input, path, "ipv4")
    return result

def encode_TextTest10(value: TextTest10) -> Any:
    return _encode_TextTest10_at(value, "$")

def decode_TextTest10(input: Any) -> TextTest10:
    return _decode_TextTest10_at(input, "$")


def _encode_TextTest11_at(value: TextTest11, path: str) -> Any:
    result = _text("encode", value, path, "ipv6")
    return result

def _decode_TextTest11_at(input: Any, path: str) -> TextTest11:
    result = _text("decode", input, path, "ipv6")
    return result

def encode_TextTest11(value: TextTest11) -> Any:
    return _encode_TextTest11_at(value, "$")

def decode_TextTest11(input: Any) -> TextTest11:
    return _decode_TextTest11_at(input, "$")


def _encode_TextTest12_at(value: TextTest12, path: str) -> Any:
    result = _text("encode", value, path, "base64")
    return result

def _decode_TextTest12_at(input: Any, path: str) -> TextTest12:
    result = _text("decode", input, path, "base64")
    return result

def encode_TextTest12(value: TextTest12) -> Any:
    return _encode_TextTest12_at(value, "$")

def decode_TextTest12(input: Any) -> TextTest12:
    return _decode_TextTest12_at(input, "$")


def _encode_TextTest13_at(value: TextTest13, path: str) -> Any:
    result = _text("encode", value, path, "base64url")
    return result

def _decode_TextTest13_at(input: Any, path: str) -> TextTest13:
    result = _text("decode", input, path, "base64url")
    return result

def encode_TextTest13(value: TextTest13) -> Any:
    return _encode_TextTest13_at(value, "$")

def decode_TextTest13(input: Any) -> TextTest13:
    return _decode_TextTest13_at(input, "$")


def _encode_TextTest14_at(value: TextTest14, path: str) -> Any:
    result = _text("encode", value, path, "e164")
    return result

def _decode_TextTest14_at(input: Any, path: str) -> TextTest14:
    result = _text("decode", input, path, "e164")
    return result

def encode_TextTest14(value: TextTest14) -> Any:
    return _encode_TextTest14_at(value, "$")

def decode_TextTest14(input: Any) -> TextTest14:
    return _decode_TextTest14_at(input, "$")


def _encode_OptionalTest0_at(value: OptionalTest0, path: str) -> Any:
    if value is None:
        result = None
    else:
        result = _text("encode", value, path, "none")
    return result

def _decode_OptionalTest0_at(input: Any, path: str) -> OptionalTest0:
    if input is None:
        result = None
    else:
        result = _text("decode", input, path, "none")
    return result

def encode_OptionalTest0(value: OptionalTest0) -> Any:
    return _encode_OptionalTest0_at(value, "$")

def decode_OptionalTest0(input: Any) -> OptionalTest0:
    return _decode_OptionalTest0_at(input, "$")


def _encode_OptionalTest1Value_at(value: OptionalTest1Value, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OptionalTest1Value_at(input: Any, path: str) -> OptionalTest1Value:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OptionalTest1Value.model_construct(**result)

def encode_OptionalTest1Value(value: OptionalTest1Value) -> Any:
    return _encode_OptionalTest1Value_at(value, "$")

def decode_OptionalTest1Value(input: Any) -> OptionalTest1Value:
    return _decode_OptionalTest1Value_at(input, "$")


def _encode_OptionalTest1_at(value: OptionalTest1, path: str) -> Any:
    if value is None:
        result = None
    else:
        result = _encode_OptionalTest1Value_at(value, path)
    return result

def _decode_OptionalTest1_at(input: Any, path: str) -> OptionalTest1:
    if input is None:
        result = None
    else:
        result = _decode_OptionalTest1Value_at(input, path)
    return result

def encode_OptionalTest1(value: OptionalTest1) -> Any:
    return _encode_OptionalTest1_at(value, "$")

def decode_OptionalTest1(input: Any) -> OptionalTest1:
    return _decode_OptionalTest1_at(input, "$")


def _encode_OptionalTest2_at(value: OptionalTest2, path: str) -> Any:
    if value is None:
        result = None
    else:
        result = _text("encode", value, path, "none")
    return result

def _decode_OptionalTest2_at(input: Any, path: str) -> OptionalTest2:
    if input is None:
        result = None
    else:
        result = _text("decode", input, path, "none")
    return result

def encode_OptionalTest2(value: OptionalTest2) -> Any:
    return _encode_OptionalTest2_at(value, "$")

def decode_OptionalTest2(input: Any) -> OptionalTest2:
    return _decode_OptionalTest2_at(input, "$")


def _encode_ListTest0_at(value: ListTest0, path: str) -> Any:
    if not isinstance(value, list):
        _fail("encode", path, "expected list")
    result = []
    for index, entry in enumerate(value):
        converted_ListTest0 = _text("encode", entry, _index(path, index), "none")
        result.append(converted_ListTest0)
    return result

def _decode_ListTest0_at(input: Any, path: str) -> ListTest0:
    result = []
    for index, entry in enumerate(_array("decode", input, path)):
        converted_ListTest0 = _text("decode", entry, _index(path, index), "none")
        result.append(converted_ListTest0)
    return result

def encode_ListTest0(value: ListTest0) -> Any:
    return _encode_ListTest0_at(value, "$")

def decode_ListTest0(input: Any) -> ListTest0:
    return _decode_ListTest0_at(input, "$")


def _encode_ListTest1_at(value: ListTest1, path: str) -> Any:
    if not isinstance(value, list):
        _fail("encode", path, "expected list")
    result = []
    for index, entry in enumerate(value):
        if not isinstance(entry, list):
            _fail("encode", _index(path, index), "expected list")
        converted_ListTest1 = []
        for index, entry in enumerate(entry):
            converted_ListTest1l = _text("encode", entry, _index(_index(path, index), index), "none")
            converted_ListTest1.append(converted_ListTest1l)
        result.append(converted_ListTest1)
    return result

def _decode_ListTest1_at(input: Any, path: str) -> ListTest1:
    result = []
    for index, entry in enumerate(_array("decode", input, path)):
        converted_ListTest1 = []
        for index, entry in enumerate(_array("decode", entry, _index(path, index))):
            converted_ListTest1l = _text("decode", entry, _index(_index(path, index), index), "none")
            converted_ListTest1.append(converted_ListTest1l)
        result.append(converted_ListTest1)
    return result

def encode_ListTest1(value: ListTest1) -> Any:
    return _encode_ListTest1_at(value, "$")

def decode_ListTest1(input: Any) -> ListTest1:
    return _decode_ListTest1_at(input, "$")


def _encode_ListTest2Values_at(value: ListTest2Values, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_ListTest2Values_at(input: Any, path: str) -> ListTest2Values:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return ListTest2Values.model_construct(**result)

def encode_ListTest2Values(value: ListTest2Values) -> Any:
    return _encode_ListTest2Values_at(value, "$")

def decode_ListTest2Values(input: Any) -> ListTest2Values:
    return _decode_ListTest2Values_at(input, "$")


def _encode_ListTest2_at(value: ListTest2, path: str) -> Any:
    if not isinstance(value, list):
        _fail("encode", path, "expected list")
    result = []
    for index, entry in enumerate(value):
        converted_ListTest2 = _encode_ListTest2Values_at(entry, _index(path, index))
        result.append(converted_ListTest2)
    return result

def _decode_ListTest2_at(input: Any, path: str) -> ListTest2:
    result = []
    for index, entry in enumerate(_array("decode", input, path)):
        converted_ListTest2 = _decode_ListTest2Values_at(entry, _index(path, index))
        result.append(converted_ListTest2)
    return result

def encode_ListTest2(value: ListTest2) -> Any:
    return _encode_ListTest2_at(value, "$")

def decode_ListTest2(input: Any) -> ListTest2:
    return _decode_ListTest2_at(input, "$")


def _encode_TupleTest0_at(value: TupleTest0, path: str) -> Any:
    entries = value
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("encode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("encode", entries[0], _index(path, 0), "none")
    result[1] = _number("encode", entries[1], _index(path, 1), "natural")
    return result

def _decode_TupleTest0_at(input: Any, path: str) -> TupleTest0:
    entries = _array("decode", input, path)
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("decode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("decode", entries[0], _index(path, 0), "none")
    result[1] = _number("decode", entries[1], _index(path, 1), "natural")
    result = tuple(result)
    return tuple(result)

def encode_TupleTest0(value: TupleTest0) -> Any:
    return _encode_TupleTest0_at(value, "$")

def decode_TupleTest0(input: Any) -> TupleTest0:
    return _decode_TupleTest0_at(input, "$")


def _encode_TupleTest1_at(value: TupleTest1, path: str) -> Any:
    entries = value
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("encode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("encode", entries[0], _index(path, 0), "none")
    result[1] = _number("encode", entries[1], _index(path, 1), "natural")
    return result

def _decode_TupleTest1_at(input: Any, path: str) -> TupleTest1:
    entries = _array("decode", input, path)
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("decode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("decode", entries[0], _index(path, 0), "none")
    result[1] = _number("decode", entries[1], _index(path, 1), "natural")
    result = tuple(result)
    return tuple(result)

def encode_TupleTest1(value: TupleTest1) -> Any:
    return _encode_TupleTest1_at(value, "$")

def decode_TupleTest1(input: Any) -> TupleTest1:
    return _decode_TupleTest1_at(input, "$")


def _encode_TupleTest2_at(value: TupleTest2, path: str) -> Any:
    entries = value
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("encode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("encode", entries[0], _index(path, 0), "none")
    entries = entries[1]
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("encode", _index(path, 1), "expected tuple of length 2")
    result[1] = [None] * 2
    result[1][0] = _text("encode", entries[0], _index(_index(path, 1), 0), "none")
    result[1][1] = _number("encode", entries[1], _index(_index(path, 1), 1), "natural")
    return result

def _decode_TupleTest2_at(input: Any, path: str) -> TupleTest2:
    entries = _array("decode", input, path)
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("decode", path, "expected tuple of length 2")
    result = [None] * 2
    result[0] = _text("decode", entries[0], _index(path, 0), "none")
    entries = _array("decode", entries[1], _index(path, 1))
    if not isinstance(entries, (list, tuple)) or len(entries) != 2:
        _fail("decode", _index(path, 1), "expected tuple of length 2")
    result[1] = [None] * 2
    result[1][0] = _text("decode", entries[0], _index(_index(path, 1), 0), "none")
    result[1][1] = _number("decode", entries[1], _index(_index(path, 1), 1), "natural")
    result[1] = tuple(result[1])
    result = tuple(result)
    return tuple(result)

def encode_TupleTest2(value: TupleTest2) -> Any:
    return _encode_TupleTest2_at(value, "$")

def decode_TupleTest2(input: Any) -> TupleTest2:
    return _decode_TupleTest2_at(input, "$")


def _encode_SetTest0_at(value: SetTest0, path: str) -> Any:
    if not isinstance(value, set):
        _fail("encode", path, "expected set")
    result = []
    for index, entry in enumerate(value):
        converted_SetTest0 = _text("encode", entry, _index(path, index), "none")
        result.append(converted_SetTest0)
    return result

def _decode_SetTest0_at(input: Any, path: str) -> SetTest0:
    result = set()
    for index, entry in enumerate(_array("decode", input, path)):
        converted_SetTest0 = _text("decode", entry, _index(path, index), "none")
        result.add(converted_SetTest0)
    return result

def encode_SetTest0(value: SetTest0) -> Any:
    return _encode_SetTest0_at(value, "$")

def decode_SetTest0(input: Any) -> SetTest0:
    return _decode_SetTest0_at(input, "$")


def _encode_SetTest1_at(value: SetTest1, path: str) -> Any:
    if not isinstance(value, list):
        _fail("encode", path, "expected list")
    result = []
    for index, entry in enumerate(value):
        converted_SetTest1 = _text("encode", entry, _index(path, index), "none")
        result.append(converted_SetTest1)
    return result

def _decode_SetTest1_at(input: Any, path: str) -> SetTest1:
    result = []
    for index, entry in enumerate(_array("decode", input, path)):
        converted_SetTest1 = _text("decode", entry, _index(path, index), "none")
        result.append(converted_SetTest1)
    return result

def encode_SetTest1(value: SetTest1) -> Any:
    return _encode_SetTest1_at(value, "$")

def decode_SetTest1(input: Any) -> SetTest1:
    return _decode_SetTest1_at(input, "$")


def _encode_SetTest2_at(value: SetTest2, path: str) -> Any:
    if not isinstance(value, set):
        _fail("encode", path, "expected set")
    result = []
    for index, entry in enumerate(value):
        if not isinstance(entry, set):
            _fail("encode", _index(path, index), "expected set")
        converted_SetTest2 = []
        for index, entry in enumerate(entry):
            converted_SetTest2l = _text("encode", entry, _index(_index(path, index), index), "none")
            converted_SetTest2.append(converted_SetTest2l)
        result.append(converted_SetTest2)
    return result

def _decode_SetTest2_at(input: Any, path: str) -> SetTest2:
    result = set()
    for index, entry in enumerate(_array("decode", input, path)):
        converted_SetTest2 = set()
        for index, entry in enumerate(_array("decode", entry, _index(path, index))):
            converted_SetTest2l = _text("decode", entry, _index(_index(path, index), index), "none")
            converted_SetTest2.add(converted_SetTest2l)
        result.add(converted_SetTest2)
    return result

def encode_SetTest2(value: SetTest2) -> Any:
    return _encode_SetTest2_at(value, "$")

def decode_SetTest2(input: Any) -> SetTest2:
    return _decode_SetTest2_at(input, "$")


def _encode_SetTest3Values_at(value: SetTest3Values, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_SetTest3Values_at(input: Any, path: str) -> SetTest3Values:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return SetTest3Values.model_construct(**result)

def encode_SetTest3Values(value: SetTest3Values) -> Any:
    return _encode_SetTest3Values_at(value, "$")

def decode_SetTest3Values(input: Any) -> SetTest3Values:
    return _decode_SetTest3Values_at(input, "$")


def _encode_SetTest3_at(value: SetTest3, path: str) -> Any:
    if not isinstance(value, set):
        _fail("encode", path, "expected set")
    result = []
    for index, entry in enumerate(value):
        converted_SetTest3 = _encode_SetTest3Values_at(entry, _index(path, index))
        result.append(converted_SetTest3)
    return result

def _decode_SetTest3_at(input: Any, path: str) -> SetTest3:
    result = set()
    for index, entry in enumerate(_array("decode", input, path)):
        converted_SetTest3 = _decode_SetTest3Values_at(entry, _index(path, index))
        result.add(converted_SetTest3)
    return result

def encode_SetTest3(value: SetTest3) -> Any:
    return _encode_SetTest3_at(value, "$")

def decode_SetTest3(input: Any) -> SetTest3:
    return _decode_SetTest3_at(input, "$")


def _encode_MapTest0_at(value: MapTest0, path: str) -> Any:
    if not isinstance(value, dict):
        _fail("encode", path, "expected dict")
    result = []
    for key, entry in value.items():
        wire_key_MapTest0 = _text("encode", key, _index(path, len(result)), "none")
        wire_value_MapTest0 = _text("encode", entry, _index(path, len(result)), "none")
        result.append({"key": wire_key_MapTest0, "value": wire_value_MapTest0})
    return result

def _decode_MapTest0_at(input: Any, path: str) -> MapTest0:
    entries = _array("decode", input, path)
    result = {}
    for index, entry in enumerate(entries):
        item = _object("decode", entry, _index(path, index))
        if "key" not in item or "value" not in item:
            _fail("decode", _index(path, index), "expected map entry")
        domain_key_MapTest0 = _text("decode", item["key"], _field(_index(path, index), "key"), "none")
        domain_value_MapTest0 = _text("decode", item["value"], _field(_index(path, index), "value"), "none")
        result[domain_key_MapTest0] = domain_value_MapTest0
    return result

def encode_MapTest0(value: MapTest0) -> Any:
    return _encode_MapTest0_at(value, "$")

def decode_MapTest0(input: Any) -> MapTest0:
    return _decode_MapTest0_at(input, "$")


def _encode_MapTest1_at(value: MapTest1, path: str) -> Any:
    if not isinstance(value, dict):
        _fail("encode", path, "expected dict")
    result = {}
    for key, entry in value.items():
        wire_key_MapTest1 = _text("encode", key, _field(path, str(key)), "none")
        if not isinstance(wire_key_MapTest1, str):
            _fail("encode", path, "record map keys must encode as strings")
        wire_value_MapTest1 = _text("encode", entry, _field(path, wire_key_MapTest1), "none")
        result[wire_key_MapTest1] = wire_value_MapTest1
    return result

def _decode_MapTest1_at(input: Any, path: str) -> MapTest1:
    object = _object("decode", input, path)
    result = {}
    for key, entry in object.items():
        domain_key_MapTest1 = _text("decode", key, _field(path, key), "none")
        if not isinstance(domain_key_MapTest1, str):
            _fail("decode", path, "record map keys must decode as strings")
        domain_value_MapTest1 = _text("decode", entry, _field(path, key), "none")
        result[domain_key_MapTest1] = domain_value_MapTest1
    return result

def encode_MapTest1(value: MapTest1) -> Any:
    return _encode_MapTest1_at(value, "$")

def decode_MapTest1(input: Any) -> MapTest1:
    return _decode_MapTest1_at(input, "$")


def _encode_MapTest2_at(value: MapTest2, path: str) -> Any:
    if not isinstance(value, dict):
        _fail("encode", path, "expected dict")
    result = []
    for key, entry in value.items():
        wire_key_MapTest2 = _text("encode", key, _index(path, len(result)), "none")
        if not isinstance(entry, dict):
            _fail("encode", _index(path, len(result)), "expected dict")
        wire_value_MapTest2 = []
        for key, entry in entry.items():
            wire_key_MapTest2v = _text("encode", key, _index(_index(path, len(result)), len(wire_value_MapTest2)), "none")
            wire_value_MapTest2v = _text("encode", entry, _index(_index(path, len(result)), len(wire_value_MapTest2)), "none")
            wire_value_MapTest2.append({"key": wire_key_MapTest2v, "value": wire_value_MapTest2v})
        result.append({"key": wire_key_MapTest2, "value": wire_value_MapTest2})
    return result

def _decode_MapTest2_at(input: Any, path: str) -> MapTest2:
    entries = _array("decode", input, path)
    result = {}
    for index, entry in enumerate(entries):
        item = _object("decode", entry, _index(path, index))
        if "key" not in item or "value" not in item:
            _fail("decode", _index(path, index), "expected map entry")
        domain_key_MapTest2 = _text("decode", item["key"], _field(_index(path, index), "key"), "none")
        entries = _array("decode", item["value"], _field(_index(path, index), "value"))
        domain_value_MapTest2 = {}
        for index, entry in enumerate(entries):
            item = _object("decode", entry, _index(_field(_index(path, index), "value"), index))
            if "key" not in item or "value" not in item:
                _fail("decode", _index(_field(_index(path, index), "value"), index), "expected map entry")
            domain_key_MapTest2v = _text("decode", item["key"], _field(_index(_field(_index(path, index), "value"), index), "key"), "none")
            domain_value_MapTest2v = _text("decode", item["value"], _field(_index(_field(_index(path, index), "value"), index), "value"), "none")
            domain_value_MapTest2[domain_key_MapTest2v] = domain_value_MapTest2v
        result[domain_key_MapTest2] = domain_value_MapTest2
    return result

def encode_MapTest2(value: MapTest2) -> Any:
    return _encode_MapTest2_at(value, "$")

def decode_MapTest2(input: Any) -> MapTest2:
    return _decode_MapTest2_at(input, "$")


def _encode_MapTest3Keys_at(value: MapTest3Keys, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_MapTest3Keys_at(input: Any, path: str) -> MapTest3Keys:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return MapTest3Keys.model_construct(**result)

def encode_MapTest3Keys(value: MapTest3Keys) -> Any:
    return _encode_MapTest3Keys_at(value, "$")

def decode_MapTest3Keys(input: Any) -> MapTest3Keys:
    return _decode_MapTest3Keys_at(input, "$")


def _encode_MapTest3Values_at(value: MapTest3Values, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_MapTest3Values_at(input: Any, path: str) -> MapTest3Values:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return MapTest3Values.model_construct(**result)

def encode_MapTest3Values(value: MapTest3Values) -> Any:
    return _encode_MapTest3Values_at(value, "$")

def decode_MapTest3Values(input: Any) -> MapTest3Values:
    return _decode_MapTest3Values_at(input, "$")


def _encode_MapTest3_at(value: MapTest3, path: str) -> Any:
    if not isinstance(value, dict):
        _fail("encode", path, "expected dict")
    result = []
    for key, entry in value.items():
        wire_key_MapTest3 = _encode_MapTest3Keys_at(key, _index(path, len(result)))
        wire_value_MapTest3 = _encode_MapTest3Values_at(entry, _index(path, len(result)))
        result.append({"key": wire_key_MapTest3, "value": wire_value_MapTest3})
    return result

def _decode_MapTest3_at(input: Any, path: str) -> MapTest3:
    entries = _array("decode", input, path)
    result = {}
    for index, entry in enumerate(entries):
        item = _object("decode", entry, _index(path, index))
        if "key" not in item or "value" not in item:
            _fail("decode", _index(path, index), "expected map entry")
        domain_key_MapTest3 = _decode_MapTest3Keys_at(item["key"], _field(_index(path, index), "key"))
        domain_value_MapTest3 = _decode_MapTest3Values_at(item["value"], _field(_index(path, index), "value"))
        result[domain_key_MapTest3] = domain_value_MapTest3
    return result

def encode_MapTest3(value: MapTest3) -> Any:
    return _encode_MapTest3_at(value, "$")

def decode_MapTest3(input: Any) -> MapTest3:
    return _decode_MapTest3_at(input, "$")


def _encode_RecordTest0_at(value: RecordTest0, path: str) -> Any:
    result = {}
    result["age"] = None
    result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    result["deceased"] = None
    if not isinstance(value.deceased, bool):
        _fail("encode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = value.deceased
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    return result

def _decode_RecordTest0_at(input: Any, path: str) -> RecordTest0:
    object = _object("decode", input, path)
    result = {}
    if "age" not in object:
        _fail("decode", _field(path, "age"), "missing required field")
    result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    if "deceased" not in object:
        _fail("decode", _field(path, "deceased"), "missing required field")
    if not isinstance(object["deceased"], bool):
        _fail("decode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = object["deceased"]
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    return RecordTest0.model_construct(**result)

def encode_RecordTest0(value: RecordTest0) -> Any:
    return _encode_RecordTest0_at(value, "$")

def decode_RecordTest0(input: Any) -> RecordTest0:
    return _decode_RecordTest0_at(input, "$")


def _encode_RecordTest1_at(value: RecordTest1, path: str) -> Any:
    result = {}
    result["age"] = None
    result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    result["deceased"] = None
    if not isinstance(value.deceased, bool):
        _fail("encode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = value.deceased
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    return result

def _decode_RecordTest1_at(input: Any, path: str) -> RecordTest1:
    object = _object("decode", input, path)
    result = {}
    if "age" not in object:
        _fail("decode", _field(path, "age"), "missing required field")
    result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    if "deceased" not in object:
        _fail("decode", _field(path, "deceased"), "missing required field")
    if not isinstance(object["deceased"], bool):
        _fail("decode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = object["deceased"]
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    return RecordTest1.model_construct(**result)

def encode_RecordTest1(value: RecordTest1) -> Any:
    return _encode_RecordTest1_at(value, "$")

def decode_RecordTest1(input: Any) -> RecordTest1:
    return _decode_RecordTest1_at(input, "$")


def _encode_RecordTest2Contact_at(value: RecordTest2Contact, path: str) -> Any:
    result = {}
    if value.email is not None:
        result["email"] = _text("encode", value.email, _field(path, "email"), "none")
    if value.phone is not None:
        result["phone"] = _text("encode", value.phone, _field(path, "phone"), "none")
    return result

def _decode_RecordTest2Contact_at(input: Any, path: str) -> RecordTest2Contact:
    object = _object("decode", input, path)
    result = {}
    if "email" in object and object["email"] is not None:
        result["email"] = _text("decode", object["email"], _field(path, "email"), "none")
    else:
        result["email"] = None
    if "phone" in object and object["phone"] is not None:
        result["phone"] = _text("decode", object["phone"], _field(path, "phone"), "none")
    else:
        result["phone"] = None
    return RecordTest2Contact.model_construct(**result)

def encode_RecordTest2Contact(value: RecordTest2Contact) -> Any:
    return _encode_RecordTest2Contact_at(value, "$")

def decode_RecordTest2Contact(input: Any) -> RecordTest2Contact:
    return _decode_RecordTest2Contact_at(input, "$")


def _encode_RecordTest2_at(value: RecordTest2, path: str) -> Any:
    result = {}
    result["age"] = None
    result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    result["contact"] = None
    result["contact"] = _encode_RecordTest2Contact_at(value.contact, _field(path, "contact"))
    result["deceased"] = None
    if not isinstance(value.deceased, bool):
        _fail("encode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = value.deceased
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    return result

def _decode_RecordTest2_at(input: Any, path: str) -> RecordTest2:
    object = _object("decode", input, path)
    result = {}
    if "age" not in object:
        _fail("decode", _field(path, "age"), "missing required field")
    result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    if "contact" not in object:
        _fail("decode", _field(path, "contact"), "missing required field")
    result["contact"] = _decode_RecordTest2Contact_at(object["contact"], _field(path, "contact"))
    if "deceased" not in object:
        _fail("decode", _field(path, "deceased"), "missing required field")
    if not isinstance(object["deceased"], bool):
        _fail("decode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = object["deceased"]
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    return RecordTest2.model_construct(**result)

def encode_RecordTest2(value: RecordTest2) -> Any:
    return _encode_RecordTest2_at(value, "$")

def decode_RecordTest2(input: Any) -> RecordTest2:
    return _decode_RecordTest2_at(input, "$")


def _encode_RecordTest3_at(value: RecordTest3, path: str) -> Any:
    result = {}
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    if value.age is not None:
        result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    if value.deceased is not None:
        if not isinstance(value.deceased, bool):
            _fail("encode", _field(path, "deceased"), "expected boolean")
        result["deceased"] = value.deceased
    return result

def _decode_RecordTest3_at(input: Any, path: str) -> RecordTest3:
    object = _object("decode", input, path)
    result = {}
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    if "age" in object and object["age"] is not None:
        result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    else:
        result["age"] = None
    if "deceased" in object and object["deceased"] is not None:
        if not isinstance(object["deceased"], bool):
            _fail("decode", _field(path, "deceased"), "expected boolean")
        result["deceased"] = object["deceased"]
    else:
        result["deceased"] = None
    return RecordTest3.model_construct(**result)

def encode_RecordTest3(value: RecordTest3) -> Any:
    return _encode_RecordTest3_at(value, "$")

def decode_RecordTest3(input: Any) -> RecordTest3:
    return _decode_RecordTest3_at(input, "$")

class _RecordTest4(BaseModel):
    id: str
    status: str
    age: int | None = None

def _encode_RecordTest4_at(value: RecordTest4, path: str) -> Any:
    result = {}
    result["id"] = None
    result["id"] = _text("encode", value.id, _field(path, "id"), "none")
    result["status"] = None
    result["status"] = _text("encode", value.status, _field(path, "status"), "none")
    if value.age is not None:
        result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    return result

def _decode_RecordTest4_at(input: Any, path: str) -> RecordTest4:
    object = _object("decode", input, path)
    result = {}
    if "id" not in object:
        _fail("decode", _field(path, "id"), "missing required field")
    result["id"] = _text("decode", object["id"], _field(path, "id"), "none")
    if "status" not in object:
        _fail("decode", _field(path, "status"), "missing required field")
    result["status"] = _text("decode", object["status"], _field(path, "status"), "none")
    if "age" in object and object["age"] is not None:
        result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    else:
        result["age"] = None
    return _RecordTest4.model_construct(**result)

def encode_RecordTest4(value: RecordTest4) -> Any:
    return _encode_RecordTest4_at(value, "$")

def decode_RecordTest4(input: Any) -> RecordTest4:
    return _decode_RecordTest4_at(input, "$")


def _encode_TimeTest0_at(value: TimeTest0, path: str) -> Any:
    result = _time("encode", value, path, "none")
    return result

def _decode_TimeTest0_at(input: Any, path: str) -> TimeTest0:
    result = _time("decode", input, path, "none")
    return result

def encode_TimeTest0(value: TimeTest0) -> Any:
    return _encode_TimeTest0_at(value, "$")

def decode_TimeTest0(input: Any) -> TimeTest0:
    return _decode_TimeTest0_at(input, "$")


def _encode_TimeTest1_at(value: TimeTest1, path: str) -> Any:
    result = _time("encode", value, path, "none")
    return result

def _decode_TimeTest1_at(input: Any, path: str) -> TimeTest1:
    result = _time("decode", input, path, "none")
    return result

def encode_TimeTest1(value: TimeTest1) -> Any:
    return _encode_TimeTest1_at(value, "$")

def decode_TimeTest1(input: Any) -> TimeTest1:
    return _decode_TimeTest1_at(input, "$")


def _encode_TimeTest2_at(value: TimeTest2, path: str) -> Any:
    result = _time("encode", value, path, "date")
    return result

def _decode_TimeTest2_at(input: Any, path: str) -> TimeTest2:
    result = _time("decode", input, path, "date")
    return result

def encode_TimeTest2(value: TimeTest2) -> Any:
    return _encode_TimeTest2_at(value, "$")

def decode_TimeTest2(input: Any) -> TimeTest2:
    return _decode_TimeTest2_at(input, "$")


def _encode_TimeTest3_at(value: TimeTest3, path: str) -> Any:
    result = _time("encode", value, path, "time")
    return result

def _decode_TimeTest3_at(input: Any, path: str) -> TimeTest3:
    result = _time("decode", input, path, "time")
    return result

def encode_TimeTest3(value: TimeTest3) -> Any:
    return _encode_TimeTest3_at(value, "$")

def decode_TimeTest3(input: Any) -> TimeTest3:
    return _decode_TimeTest3_at(input, "$")


def _encode_TimeTest4_at(value: TimeTest4, path: str) -> Any:
    result = _time("encode", value, path, "duration")
    return result

def _decode_TimeTest4_at(input: Any, path: str) -> TimeTest4:
    result = _time("decode", input, path, "duration")
    return result

def encode_TimeTest4(value: TimeTest4) -> Any:
    return _encode_TimeTest4_at(value, "$")

def decode_TimeTest4(input: Any) -> TimeTest4:
    return _decode_TimeTest4_at(input, "$")


def _encode_AnyTest0_at(value: AnyTest0, path: str) -> Any:
    result = _any("encode", value, path)
    return result

def _decode_AnyTest0_at(input: Any, path: str) -> AnyTest0:
    result = _any("decode", input, path)
    return result

def encode_AnyTest0(value: AnyTest0) -> Any:
    return _encode_AnyTest0_at(value, "$")

def decode_AnyTest0(input: Any) -> AnyTest0:
    return _decode_AnyTest0_at(input, "$")


def _encode_AnyTest1_at(value: AnyTest1, path: str) -> Any:
    result = _any("encode", value, path)
    return result

def _decode_AnyTest1_at(input: Any, path: str) -> AnyTest1:
    result = _any("decode", input, path)
    return result

def encode_AnyTest1(value: AnyTest1) -> Any:
    return _encode_AnyTest1_at(value, "$")

def decode_AnyTest1(input: Any) -> AnyTest1:
    return _decode_AnyTest1_at(input, "$")


def _encode_AnyTest2_at(value: AnyTest2, path: str) -> Any:
    result = _any("encode", value, path)
    return result

def _decode_AnyTest2_at(input: Any, path: str) -> AnyTest2:
    result = _any("decode", input, path)
    return result

def encode_AnyTest2(value: AnyTest2) -> Any:
    return _encode_AnyTest2_at(value, "$")

def decode_AnyTest2(input: Any) -> AnyTest2:
    return _decode_AnyTest2_at(input, "$")


def _encode_AnyTest3_at(value: AnyTest3, path: str) -> Any:
    result = _any("encode", value, path)
    return result

def _decode_AnyTest3_at(input: Any, path: str) -> AnyTest3:
    result = _any("decode", input, path)
    return result

def encode_AnyTest3(value: AnyTest3) -> Any:
    return _encode_AnyTest3_at(value, "$")

def decode_AnyTest3(input: Any) -> AnyTest3:
    return _decode_AnyTest3_at(input, "$")


def _encode_Person_at(value: Person, path: str) -> Any:
    result = {}
    result["age"] = None
    result["age"] = _number("encode", value.age, _field(path, "age"), "natural")
    result["deceased"] = None
    if not isinstance(value.deceased, bool):
        _fail("encode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = value.deceased
    result["name"] = None
    result["name"] = _text("encode", value.name, _field(path, "name"), "none")
    return result

def _decode_Person_at(input: Any, path: str) -> Person:
    object = _object("decode", input, path)
    result = {}
    if "age" not in object:
        _fail("decode", _field(path, "age"), "missing required field")
    result["age"] = _number("decode", object["age"], _field(path, "age"), "natural")
    if "deceased" not in object:
        _fail("decode", _field(path, "deceased"), "missing required field")
    if not isinstance(object["deceased"], bool):
        _fail("decode", _field(path, "deceased"), "expected boolean")
    result["deceased"] = object["deceased"]
    if "name" not in object:
        _fail("decode", _field(path, "name"), "missing required field")
    result["name"] = _text("decode", object["name"], _field(path, "name"), "none")
    return Person.model_construct(**result)

def encode_Person(value: Person) -> Any:
    return _encode_Person_at(value, "$")

def decode_Person(input: Any) -> Person:
    return _decode_Person_at(input, "$")


def _encode_People_at(value: People, path: str) -> Any:
    if not isinstance(value, list):
        _fail("encode", path, "expected list")
    result = []
    for index, entry in enumerate(value):
        converted_People = _encode_Person_at(entry, _index(path, index))
        result.append(converted_People)
    return result

def _decode_People_at(input: Any, path: str) -> People:
    result = []
    for index, entry in enumerate(_array("decode", input, path)):
        converted_People = _decode_Person_at(entry, _index(path, index))
        result.append(converted_People)
    return result

def encode_People(value: People) -> Any:
    return _encode_People_at(value, "$")

def decode_People(input: Any) -> People:
    return _decode_People_at(input, "$")


def _encode_OneOfTest0_at(value: OneOfTest0, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _text("encode", value, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("encode", value, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest0_at(input: Any, path: str) -> OneOfTest0:
    matched = False
    if not matched:
        try:
            result = _text("decode", input, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("decode", input, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest0(value: OneOfTest0) -> Any:
    return _encode_OneOfTest0_at(value, "$")

def decode_OneOfTest0(input: Any) -> OneOfTest0:
    return _decode_OneOfTest0_at(input, "$")


def _encode_OneOfTest1_at(value: OneOfTest1, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _text("encode", value, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("encode", value, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest1_at(input: Any, path: str) -> OneOfTest1:
    matched = False
    if not matched:
        try:
            result = _text("decode", input, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("decode", input, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest1(value: OneOfTest1) -> Any:
    return _encode_OneOfTest1_at(value, "$")

def decode_OneOfTest1(input: Any) -> OneOfTest1:
    return _decode_OneOfTest1_at(input, "$")


def _encode_OneOfTest2Option2_at(value: OneOfTest2Option2, path: str) -> Any:
    result = {}
    result["bar"] = None
    result["bar"] = _number("encode", value.bar, _field(path, "bar"), "none")
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OneOfTest2Option2_at(input: Any, path: str) -> OneOfTest2Option2:
    object = _object("decode", input, path)
    result = {}
    if "bar" not in object:
        _fail("decode", _field(path, "bar"), "missing required field")
    result["bar"] = _number("decode", object["bar"], _field(path, "bar"), "none")
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OneOfTest2Option2.model_construct(**result)

def encode_OneOfTest2Option2(value: OneOfTest2Option2) -> Any:
    return _encode_OneOfTest2Option2_at(value, "$")

def decode_OneOfTest2Option2(input: Any) -> OneOfTest2Option2:
    return _decode_OneOfTest2Option2_at(input, "$")


def _encode_OneOfTest2_at(value: OneOfTest2, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _text("encode", value, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("encode", value, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _encode_OneOfTest2Option2_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest2_at(input: Any, path: str) -> OneOfTest2:
    matched = False
    if not matched:
        try:
            result = _text("decode", input, path, "none")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _number("decode", input, path, "natural")
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _decode_OneOfTest2Option2_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest2(value: OneOfTest2) -> Any:
    return _encode_OneOfTest2_at(value, "$")

def decode_OneOfTest2(input: Any) -> OneOfTest2:
    return _decode_OneOfTest2_at(input, "$")


def _encode_OneOfTest3_at(value: OneOfTest3, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _encode_Foo_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _encode_Bar_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest3_at(input: Any, path: str) -> OneOfTest3:
    matched = False
    if not matched:
        try:
            result = _decode_Foo_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _decode_Bar_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest3(value: OneOfTest3) -> Any:
    return _encode_OneOfTest3_at(value, "$")

def decode_OneOfTest3(input: Any) -> OneOfTest3:
    return _decode_OneOfTest3_at(input, "$")


def _encode_OneOfTest4Option0_at(value: OneOfTest4Option0, path: str) -> Any:
    result = {}
    result["bar"] = None
    result["bar"] = _number("encode", value.bar, _field(path, "bar"), "none")
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OneOfTest4Option0_at(input: Any, path: str) -> OneOfTest4Option0:
    object = _object("decode", input, path)
    result = {}
    if "bar" not in object:
        _fail("decode", _field(path, "bar"), "missing required field")
    result["bar"] = _number("decode", object["bar"], _field(path, "bar"), "none")
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OneOfTest4Option0.model_construct(**result)

def encode_OneOfTest4Option0(value: OneOfTest4Option0) -> Any:
    return _encode_OneOfTest4Option0_at(value, "$")

def decode_OneOfTest4Option0(input: Any) -> OneOfTest4Option0:
    return _decode_OneOfTest4Option0_at(input, "$")


def _encode_OneOfTest4Option1_at(value: OneOfTest4Option1, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OneOfTest4Option1_at(input: Any, path: str) -> OneOfTest4Option1:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OneOfTest4Option1.model_construct(**result)

def encode_OneOfTest4Option1(value: OneOfTest4Option1) -> Any:
    return _encode_OneOfTest4Option1_at(value, "$")

def decode_OneOfTest4Option1(input: Any) -> OneOfTest4Option1:
    return _decode_OneOfTest4Option1_at(input, "$")


def _encode_OneOfTest4_at(value: OneOfTest4, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _encode_OneOfTest4Option0_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _encode_OneOfTest4Option1_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest4_at(input: Any, path: str) -> OneOfTest4:
    matched = False
    if not matched:
        try:
            result = _decode_OneOfTest4Option0_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _decode_OneOfTest4Option1_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest4(value: OneOfTest4) -> Any:
    return _encode_OneOfTest4_at(value, "$")

def decode_OneOfTest4(input: Any) -> OneOfTest4:
    return _decode_OneOfTest4_at(input, "$")


def _encode_OneOfTest5Option0_at(value: OneOfTest5Option0, path: str) -> Any:
    result = {}
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OneOfTest5Option0_at(input: Any, path: str) -> OneOfTest5Option0:
    object = _object("decode", input, path)
    result = {}
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OneOfTest5Option0.model_construct(**result)

def encode_OneOfTest5Option0(value: OneOfTest5Option0) -> Any:
    return _encode_OneOfTest5Option0_at(value, "$")

def decode_OneOfTest5Option0(input: Any) -> OneOfTest5Option0:
    return _decode_OneOfTest5Option0_at(input, "$")


def _encode_OneOfTest5Option1_at(value: OneOfTest5Option1, path: str) -> Any:
    result = {}
    result["bar"] = None
    result["bar"] = _number("encode", value.bar, _field(path, "bar"), "none")
    result["foo"] = None
    result["foo"] = _text("encode", value.foo, _field(path, "foo"), "none")
    return result

def _decode_OneOfTest5Option1_at(input: Any, path: str) -> OneOfTest5Option1:
    object = _object("decode", input, path)
    result = {}
    if "bar" not in object:
        _fail("decode", _field(path, "bar"), "missing required field")
    result["bar"] = _number("decode", object["bar"], _field(path, "bar"), "none")
    if "foo" not in object:
        _fail("decode", _field(path, "foo"), "missing required field")
    result["foo"] = _text("decode", object["foo"], _field(path, "foo"), "none")
    return OneOfTest5Option1.model_construct(**result)

def encode_OneOfTest5Option1(value: OneOfTest5Option1) -> Any:
    return _encode_OneOfTest5Option1_at(value, "$")

def decode_OneOfTest5Option1(input: Any) -> OneOfTest5Option1:
    return _decode_OneOfTest5Option1_at(input, "$")


def _encode_OneOfTest5_at(value: OneOfTest5, path: str) -> Any:
    matched = False
    if not matched:
        try:
            result = _encode_OneOfTest5Option0_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _encode_OneOfTest5Option1_at(value, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("encode", path, "no OneOf option matched")
    return result

def _decode_OneOfTest5_at(input: Any, path: str) -> OneOfTest5:
    matched = False
    if not matched:
        try:
            result = _decode_OneOfTest5Option0_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        try:
            result = _decode_OneOfTest5Option1_at(input, path)
            matched = True
        except CodecError:
            pass
    if not matched:
        _fail("decode", path, "no OneOf option matched")
    return result

def encode_OneOfTest5(value: OneOfTest5) -> Any:
    return _encode_OneOfTest5_at(value, "$")

def decode_OneOfTest5(input: Any) -> OneOfTest5:
    return _decode_OneOfTest5_at(input, "$")