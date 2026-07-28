from datetime import date, datetime, time, timezone

import out


def expect_codec_error(operation):
    try:
        operation()
    except out.CodecError:
        return
    raise AssertionError("expected CodecError")


def round_trip(encode, decode, value):
    return decode(encode(value))


assert round_trip(out.encode_BooleanTest0, out.decode_BooleanTest0, True) is True
expect_codec_error(lambda: out.decode_BooleanTest0(1))
expect_codec_error(lambda: out.encode_BooleanTest0("true"))

assert round_trip(out.encode_NumberTest0, out.decode_NumberTest0, -1.5) == -1.5
assert round_trip(out.encode_NumberTest2, out.decode_NumberTest2, 42) == 42
assert round_trip(out.encode_NumberTest3, out.decode_NumberTest3, -42) == -42
assert round_trip(out.encode_NumberTest4, out.decode_NumberTest4, 2.5) == 2.5
expect_codec_error(lambda: out.decode_NumberTest0("2"))
expect_codec_error(lambda: out.decode_NumberTest2(-1))
expect_codec_error(lambda: out.decode_NumberTest2(1.5))
expect_codec_error(lambda: out.decode_NumberTest3(1.5))
expect_codec_error(lambda: out.encode_NumberTest4(float("inf")))

text_cases = [
    (out.encode_TextTest0, out.decode_TextTest0, "plain text", 0),
    (out.encode_TextTest2, out.decode_TextTest2, "ada@example.com", "not-an-email"),
    (out.encode_TextTest3, out.decode_TextTest3, "https://example.com/path", "not a URL"),
    (out.encode_TextTest5, out.decode_TextTest5, "2026-07-25T14:30:00Z", "not-a-date-time"),
    (out.encode_TextTest6, out.decode_TextTest6, "2026-07-25", "not-a-date"),
    (out.encode_TextTest7, out.decode_TextTest7, "14:30:00.123", "not-a-time"),
    (out.encode_TextTest8, out.decode_TextTest8, "P1Y2M3DT4H5M6S", "not-a-duration"),
    (out.encode_TextTest9, out.decode_TextTest9, "123e4567-e89b-42d3-a456-426614174000", "not-a-uuid"),
    (out.encode_TextTest10, out.decode_TextTest10, "192.0.2.1", "999.0.0.1"),
    (out.encode_TextTest11, out.decode_TextTest11, "2001:db8::1", "not-an-ip-address"),
    (out.encode_TextTest12, out.decode_TextTest12, "+/8=", "YQ="),
    (out.encode_TextTest13, out.decode_TextTest13, "-_8=", "+/8="),
    (out.encode_TextTest14, out.decode_TextTest14, "+14155552671", "14155552671"),
]
for encode, decode, valid, invalid in text_cases:
    assert round_trip(encode, decode, valid) == valid
    expect_codec_error(lambda decode=decode, invalid=invalid: decode(invalid))

assert round_trip(out.encode_TextTest4, out.decode_TextTest4, "foo") == "foo"
expect_codec_error(lambda: out.decode_TextTest4("bar"))

assert out.encode_OptionalTest0(None) is None
assert out.decode_OptionalTest0(None) is None
assert round_trip(out.encode_OptionalTest0, out.decode_OptionalTest0, "optional") == "optional"
expect_codec_error(lambda: out.decode_OptionalTest0(0))

optional_record = out.OptionalTest1Value(foo="optional record")
decoded_optional_record = round_trip(out.encode_OptionalTest1, out.decode_OptionalTest1, optional_record)
assert decoded_optional_record.foo == "optional record"
assert out.decode_OptionalTest1(None) is None

assert round_trip(out.encode_OptionalTest2, out.decode_OptionalTest2, "nested optional") == "nested optional"

assert round_trip(out.encode_ListTest0, out.decode_ListTest0, ["one", "two"]) == ["one", "two"]
assert round_trip(out.encode_ListTest1, out.decode_ListTest1, [["one"], ["two", "three"]])[1][1] == "three"
list_record = out.ListTest2Values(foo="value")
assert round_trip(out.encode_ListTest2, out.decode_ListTest2, [list_record])[0].foo == "value"
expect_codec_error(lambda: out.decode_ListTest0("not-a-list"))
expect_codec_error(lambda: out.decode_ListTest0(["valid", 0]))

assert round_trip(out.encode_TupleTest0, out.decode_TupleTest0, ("one", 1)) == ("one", 1)
assert round_trip(out.encode_TupleTest1, out.decode_TupleTest1, ("two", 2)) == ("two", 2)
assert round_trip(out.encode_TupleTest2, out.decode_TupleTest2, ("outer", ("inner", 3))) == ("outer", ("inner", 3))
expect_codec_error(lambda: out.decode_TupleTest0(["one"]))
expect_codec_error(lambda: out.decode_TupleTest0(["one", -1]))

assert round_trip(out.encode_SetTest0, out.decode_SetTest0, {"one", "two"}) == {"one", "two"}
assert round_trip(out.encode_SetTest1, out.decode_SetTest1, ["one", "two"]) == ["one", "two"]
expect_codec_error(lambda: out.decode_SetTest0("not-a-set"))
expect_codec_error(lambda: out.decode_SetTest0(["valid", 0]))

assert round_trip(out.encode_MapTest0, out.decode_MapTest0, {"one": "two"}) == {"one": "two"}
assert round_trip(out.encode_MapTest1, out.decode_MapTest1, {"one": "two"}) == {"one": "two"}
nested_map = round_trip(out.encode_MapTest2, out.decode_MapTest2, {"outer": {"inner": "value"}})
assert nested_map["outer"]["inner"] == "value"
expect_codec_error(lambda: out.decode_MapTest0("not-a-map"))
expect_codec_error(lambda: out.decode_MapTest0([{"key": "one", "value": 0}]))

required_record = out.RecordTest0(age=36, deceased=False, name="Ada")
decoded_required_record = round_trip(out.encode_RecordTest0, out.decode_RecordTest0, required_record)
assert decoded_required_record.name == "Ada"
assert decoded_required_record.age == 36
expect_codec_error(lambda: out.decode_RecordTest0({"age": 36, "deceased": False}))
expect_codec_error(lambda: out.decode_RecordTest0({"age": -1, "deceased": False, "name": "Ada"}))

nested_record = out.RecordTest2(
    age=36,
    contact=out.RecordTest2Contact(email="ada@example.com", phone=None),
    deceased=False,
    name="Ada",
)
decoded_nested_record = round_trip(out.encode_RecordTest2, out.decode_RecordTest2, nested_record)
assert decoded_nested_record.contact.email == "ada@example.com"
assert decoded_nested_record.contact.phone is None

optional_record = out.RecordTest3(name="Ada", age=None, deceased=None)
decoded_optional_record = round_trip(out.encode_RecordTest3, out.decode_RecordTest3, optional_record)
assert decoded_optional_record.age is None
assert decoded_optional_record.deceased is None
present_optional_record = out.RecordTest3(name="Grace", age=85, deceased=True)
assert round_trip(out.encode_RecordTest3, out.decode_RecordTest3, present_optional_record).age == 85

interface_record = out.decode_RecordTest4({"id": "person-1", "status": "active", "age": 36})
assert interface_record.id == "person-1"
assert interface_record.status == "active"
assert interface_record.age == 36
assert out.encode_RecordTest4(interface_record) == {"id": "person-1", "status": "active", "age": 36}
expect_codec_error(lambda: out.decode_RecordTest4({"id": "person-1"}))

instant = datetime(2026, 7, 25, 14, 30, 0, 123000, timezone.utc)
assert round_trip(out.encode_TimeTest0, out.decode_TimeTest0, instant) == instant
assert round_trip(out.encode_TimeTest1, out.decode_TimeTest1, instant) == instant
calendar_date = date(1815, 12, 10)
assert round_trip(out.encode_TimeTest2, out.decode_TimeTest2, calendar_date) == calendar_date
local_time = time(14, 30, 0, 123000)
assert round_trip(out.encode_TimeTest3, out.decode_TimeTest3, local_time) == local_time
assert round_trip(out.encode_TimeTest4, out.decode_TimeTest4, "P1Y2M3DT4H5M6S") == "P1Y2M3DT4H5M6S"
expect_codec_error(lambda: out.decode_TimeTest0("not-an-instant"))
expect_codec_error(lambda: out.decode_TimeTest2("not-a-date"))
expect_codec_error(lambda: out.decode_TimeTest3("not-a-time"))
expect_codec_error(lambda: out.decode_TimeTest4("not-a-duration"))

json_value = {"items": [1, {"ok": True}]}
assert out.encode_AnyTest0(json_value) is json_value
assert out.decode_AnyTest0(json_value) is json_value
expect_codec_error(lambda: out.decode_AnyTest0(object()))
expect_codec_error(lambda: out.encode_AnyTest0(float("inf")))

core_person = out.Person(age=36, deceased=False, name="Ada")
assert round_trip(out.encode_Person, out.decode_Person, core_person).name == "Ada"
people = round_trip(
    out.encode_People,
    out.decode_People,
    [core_person, out.Person(age=85, deceased=True, name="Grace")],
)
assert people[1].name == "Grace"
expect_codec_error(lambda: out.decode_People([{"age": 36, "deceased": False}]))

assert round_trip(out.encode_OneOfTest0, out.decode_OneOfTest0, "text value") == "text value"
assert round_trip(out.encode_OneOfTest0, out.decode_OneOfTest0, 42) == 42
assert round_trip(out.encode_OneOfTest1, out.decode_OneOfTest1, 7) == 7
one_of_record = out.OneOfTest2Option2(bar=1, foo="details")
assert round_trip(out.encode_OneOfTest2, out.decode_OneOfTest2, one_of_record).foo == "details"
assert round_trip(out.encode_OneOfTest3, out.decode_OneOfTest3, "foo") == "foo"
expect_codec_error(lambda: out.decode_OneOfTest0(-1))

extended_first = out.decode_OneOfTest4({"foo": "overlap", "bar": 1})
assert extended_first.foo == "overlap"
assert extended_first.bar == 1
base_first = out.decode_OneOfTest5({"foo": "overlap", "bar": 1})
assert base_first.foo == "overlap"
assert not hasattr(base_first, "bar")

base_option = out.OneOfTest5Option0(foo="base")
extended_option = out.OneOfTest5Option1(foo="extended", bar=1)
assert out.encode_OneOfTest5(base_option) == {"foo": "base"}
assert out.encode_OneOfTest5(extended_option) == {"foo": "extended"}

extended_first_option = out.OneOfTest4Option0(foo="extended", bar=1)
assert out.encode_OneOfTest4(extended_first_option) == {"bar": 1, "foo": "extended"}
