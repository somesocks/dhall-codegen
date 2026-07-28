import {
  CodecError,
  decodePeople,
  decodePerson,
  decodeAnyTest0,
  decodeAnyTest1,
  decodeBooleanTest0,
  decodeNumberTest0,
  decodeNumberTest2,
  decodeNumberTest3,
  decodeNumberTest4,
  encodeBooleanTest0,
  encodePeople,
  encodePerson,
  encodeAnyTest0,
  encodeAnyTest1,
  encodeNumberTest0,
  encodeNumberTest2,
  encodeNumberTest3,
  encodeNumberTest4,
  decodeTimeTest0,
  decodeTimeTest1,
  decodeTimeTest2,
  decodeTimeTest3,
  decodeTimeTest4,
  encodeTimeTest0,
  encodeTimeTest1,
  encodeTimeTest2,
  encodeTimeTest3,
  encodeTimeTest4,
  decodeRecordTest0,
  decodeRecordTest1,
  decodeRecordTest2,
  decodeRecordTest3,
  decodeRecordTest4,
  encodeRecordTest0,
  encodeRecordTest1,
  encodeRecordTest2,
  encodeRecordTest3,
  encodeRecordTest4,
  decodeMapTest0,
  decodeMapTest1,
  decodeMapTest2,
  decodeMapTest3,
  encodeMapTest0,
  encodeMapTest1,
  encodeMapTest2,
  encodeMapTest3,
  decodeSetTest0,
  decodeSetTest1,
  decodeSetTest2,
  decodeSetTest3,
  encodeSetTest0,
  encodeSetTest1,
  encodeSetTest2,
  encodeSetTest3,
  decodeTupleTest0,
  decodeTupleTest1,
  decodeTupleTest2,
  encodeTupleTest0,
  encodeTupleTest1,
  encodeTupleTest2,
  decodeListTest0,
  decodeListTest1,
  decodeListTest2,
  encodeListTest0,
  encodeListTest1,
  encodeListTest2,
  decodeOptionalTest0,
  decodeOptionalTest1,
  decodeOptionalTest2,
  decodeOneOfTest0,
  decodeOneOfTest1,
  decodeOneOfTest2,
  decodeOneOfTest3,
  decodeOneOfTest4,
  decodeOneOfTest5,
  encodeOptionalTest0,
  encodeOptionalTest1,
  encodeOptionalTest2,
  encodeOneOfTest0,
  encodeOneOfTest1,
  encodeOneOfTest2,
  encodeOneOfTest3,
  encodeOneOfTest4,
  encodeOneOfTest5,
  decodeTextTest0,
  decodeTextTest2,
  decodeTextTest3,
  decodeTextTest4,
  decodeTextTest5,
  decodeTextTest6,
  decodeTextTest7,
  decodeTextTest8,
  decodeTextTest9,
  decodeTextTest10,
  decodeTextTest11,
  decodeTextTest12,
  decodeTextTest13,
  decodeTextTest14,
  encodeTextTest0,
  encodeTextTest2,
  encodeTextTest3,
  encodeTextTest4,
  encodeTextTest5,
  encodeTextTest6,
  encodeTextTest7,
  encodeTextTest8,
  encodeTextTest9,
  encodeTextTest10,
  encodeTextTest11,
  encodeTextTest12,
  encodeTextTest13,
  encodeTextTest14,
} from "./out";

const expectCodecError = (operation: () => unknown): void => {
  try {
    operation();
  } catch (error) {
    if (error instanceof CodecError) return;
    throw error;
  }

  throw new Error("expected CodecError");
};

const expectTextRoundTrip = (
  encode: (value: string) => unknown,
  decode: (input: unknown) => string,
  value: string,
): void => {
  if (decode(encode(value)) !== value) throw new Error("text did not round-trip");
};

if (encodeBooleanTest0(true) !== true || decodeBooleanTest0(false) !== false) {
  throw new Error("boolean did not round-trip");
}
expectCodecError(() => decodeBooleanTest0(0));
expectCodecError(() => decodeBooleanTest0("true"));
expectCodecError(() => decodeBooleanTest0(null));

if (encodeNumberTest0(-1.5) !== -1.5 || decodeNumberTest0(2.5) !== 2.5) {
  throw new Error("number did not round-trip");
}
expectCodecError(() => decodeNumberTest0("2"));
expectCodecError(() => encodeNumberTest0(Number.NaN));
expectCodecError(() => encodeNumberTest0(Number.POSITIVE_INFINITY));

if (encodeNumberTest2(0) !== 0 || decodeNumberTest2(42) !== 42) {
  throw new Error("natural number did not round-trip");
}
expectCodecError(() => decodeNumberTest2(-1));
expectCodecError(() => decodeNumberTest2(1.5));

if (encodeNumberTest3(-42) !== -42 || decodeNumberTest3(0) !== 0) {
  throw new Error("integer did not round-trip");
}
expectCodecError(() => decodeNumberTest3(1.5));

if (encodeNumberTest4(1.5) !== 1.5 || decodeNumberTest4(-2) !== -2) {
  throw new Error("decimal number did not round-trip");
}
expectCodecError(() => decodeNumberTest4(Number.NEGATIVE_INFINITY));

expectTextRoundTrip(encodeTextTest0, decodeTextTest0, "plain text");
expectCodecError(() => decodeTextTest0(0));

expectTextRoundTrip(encodeTextTest2, decodeTextTest2, "ada@example.com");
expectCodecError(() => decodeTextTest2("not-an-email"));

expectTextRoundTrip(encodeTextTest3, decodeTextTest3, "https://example.com/path");
expectCodecError(() => decodeTextTest3("not a URL"));

if (decodeTextTest4(encodeTextTest4("foo")) !== "foo") {
  throw new Error("literal text did not round-trip");
}
expectCodecError(() => decodeTextTest4("bar"));

expectTextRoundTrip(encodeTextTest5, decodeTextTest5, "2026-07-25T14:30:00Z");
expectCodecError(() => decodeTextTest5("not-a-date-time"));

expectTextRoundTrip(encodeTextTest6, decodeTextTest6, "2026-07-25");
expectCodecError(() => decodeTextTest6("not-a-date"));

expectTextRoundTrip(encodeTextTest7, decodeTextTest7, "14:30:00.123");
expectCodecError(() => decodeTextTest7("not-a-time"));

expectTextRoundTrip(encodeTextTest8, decodeTextTest8, "P1Y2M3DT4H5M6S");
expectCodecError(() => decodeTextTest8("not-a-duration"));

expectTextRoundTrip(encodeTextTest9, decodeTextTest9, "123e4567-e89b-42d3-a456-426614174000");
expectCodecError(() => decodeTextTest9("not-a-uuid"));

expectTextRoundTrip(encodeTextTest10, decodeTextTest10, "192.0.2.1");
expectCodecError(() => decodeTextTest10("999.0.0.1"));

expectTextRoundTrip(encodeTextTest11, decodeTextTest11, "2001:db8::1");
expectCodecError(() => decodeTextTest11("not-an-ip-address"));

expectTextRoundTrip(encodeTextTest12, decodeTextTest12, "+/8=");
expectCodecError(() => decodeTextTest12("YQ="));

expectTextRoundTrip(encodeTextTest13, decodeTextTest13, "-_8=");
expectCodecError(() => decodeTextTest13("+/8="));

expectTextRoundTrip(encodeTextTest14, decodeTextTest14, "+14155552671");
expectCodecError(() => decodeTextTest14("14155552671"));

if (encodeOptionalTest0(undefined) !== null || decodeOptionalTest0(null) !== undefined) {
  throw new Error("optional text null handling failed");
}
if (decodeOptionalTest0(encodeOptionalTest0("optional text")) !== "optional text") {
  throw new Error("optional text did not round-trip");
}
expectCodecError(() => decodeOptionalTest0(0));

const optionalRecord = decodeOptionalTest1(encodeOptionalTest1({ foo: "optional record" }));
if (optionalRecord?.foo !== "optional record") throw new Error("optional record did not round-trip");
if (encodeOptionalTest1(undefined) !== null || decodeOptionalTest1(null) !== undefined) {
  throw new Error("optional record null handling failed");
}

if (decodeOptionalTest2(encodeOptionalTest2("nested optional")) !== "nested optional") {
  throw new Error("nested optional did not round-trip");
}
if (encodeOptionalTest2(undefined) !== null || decodeOptionalTest2(null) !== undefined) {
  throw new Error("nested optional null handling failed");
}

const textList = decodeListTest0(encodeListTest0(["one", "two"]));
if (textList.length !== 2 || textList[0] !== "one" || textList[1] !== "two") {
  throw new Error("text list did not round-trip");
}
expectCodecError(() => decodeListTest0("not an array"));
expectCodecError(() => decodeListTest0(["valid", 0]));

const nestedTextList = decodeListTest1(encodeListTest1([["one"], ["two", "three"]]));
if (nestedTextList[1]?.[1] !== "three") throw new Error("nested text list did not round-trip");
expectCodecError(() => decodeListTest1([["valid", 0]]));

const recordList = decodeListTest2(encodeListTest2([{ foo: "record" }]));
if (recordList[0]?.foo !== "record") throw new Error("record list did not round-trip");
expectCodecError(() => decodeListTest2([{}]));

const tuple = decodeTupleTest0(encodeTupleTest0(["tuple", 2]));
if (tuple[0] !== "tuple" || tuple[1] !== 2) throw new Error("tuple did not round-trip");
if (decodeTupleTest1(encodeTupleTest1(["tuple", 3]))[1] !== 3) {
  throw new Error("described tuple did not round-trip");
}
expectCodecError(() => decodeTupleTest0("not an array"));
expectCodecError(() => decodeTupleTest0(["tuple"]));
expectCodecError(() => decodeTupleTest0(["tuple", -1]));

const nestedTuple = decodeTupleTest2(encodeTupleTest2(["outer", ["inner", 4]]));
if (nestedTuple[1][0] !== "inner" || nestedTuple[1][1] !== 4) {
  throw new Error("nested tuple did not round-trip");
}
expectCodecError(() => decodeTupleTest2(["outer", ["inner"]]));
expectCodecError(() => decodeTupleTest2(["outer", ["inner", -1]]));

const textSet = decodeSetTest0(encodeSetTest0(new Set(["one", "two"])));
if (!(textSet instanceof Set) || !textSet.has("one") || !textSet.has("two")) {
  throw new Error("text set did not round-trip");
}
expectCodecError(() => decodeSetTest0("not an array"));
expectCodecError(() => decodeSetTest0(["valid", 0]));

const setList = decodeSetTest1(encodeSetTest1(["one", "two"]));
if (!Array.isArray(setList) || setList[1] !== "two") throw new Error("set list did not round-trip");
expectCodecError(() => decodeSetTest1(["valid", 0]));

const nestedSet = decodeSetTest2(encodeSetTest2(new Set([new Set(["nested"])])));
const nestedSetEntry = [...nestedSet][0];
if (!(nestedSetEntry instanceof Set) || !nestedSetEntry.has("nested")) {
  throw new Error("nested set did not round-trip");
}
expectCodecError(() => decodeSetTest2([["valid", 0]]));

const recordSet = decodeSetTest3(encodeSetTest3(new Set([{ foo: "record" }])));
const recordSetEntry = [...recordSet][0];
if (recordSetEntry?.foo !== "record") throw new Error("record set did not round-trip");
expectCodecError(() => decodeSetTest3([{}]));

const textMapInput = new Map([["one", "first"], ["two", "second"]]);
const encodedTextMap = encodeMapTest0(textMapInput);
if (!Array.isArray(encodedTextMap) || encodedTextMap.length !== 2) {
  throw new Error("map did not encode as entries");
}
const textMap = decodeMapTest0(encodedTextMap);
if (!(textMap instanceof Map) || textMap.get("two") !== "second") {
  throw new Error("text map did not round-trip");
}
expectCodecError(() => decodeMapTest0("not an array"));
expectCodecError(() => decodeMapTest0([{}]));
expectCodecError(() => decodeMapTest0([{ key: "valid", value: 0 }]));

const recordMap = decodeMapTest1(encodeMapTest1({ one: "first", two: "second" }));
if (recordMap.one !== "first" || recordMap.two !== "second") {
  throw new Error("record map did not round-trip");
}
expectCodecError(() => decodeMapTest1("not an object"));
expectCodecError(() => decodeMapTest1({ valid: 0 }));

const nestedMap = decodeMapTest2(encodeMapTest2(new Map([["outer", new Map([["inner", "value"]])]])));
if (nestedMap.get("outer")?.get("inner") !== "value") {
  throw new Error("nested map did not round-trip");
}
expectCodecError(() => decodeMapTest2([{ key: "outer", value: [{ key: "inner", value: 0 }] }]));

const recordKeyValueMap = decodeMapTest3(encodeMapTest3(new Map([[{ foo: "key" }, { foo: "value" }]])));
const recordMapEntry = [...recordKeyValueMap][0];
if (recordMapEntry?.[0].foo !== "key" || recordMapEntry[1].foo !== "value") {
  throw new Error("record key/value map did not round-trip");
}
expectCodecError(() => decodeMapTest3([{ key: {}, value: { foo: "value" } }]));

const requiredRecord = decodeRecordTest0(encodeRecordTest0({ age: 36, deceased: false, name: "Ada" }));
if (requiredRecord.name !== "Ada" || requiredRecord.age !== 36 || requiredRecord.deceased !== false) {
  throw new Error("required record did not round-trip");
}
if (decodeRecordTest1(encodeRecordTest1({ age: 85, deceased: true, name: "Grace" })).name !== "Grace") {
  throw new Error("described record did not round-trip");
}
expectCodecError(() => decodeRecordTest0({ age: 36, deceased: false }));
expectCodecError(() => decodeRecordTest0({ age: -1, deceased: false, name: "Ada" }));

const nestedRecord = decodeRecordTest2(encodeRecordTest2({
  age: 36,
  contact: { email: "ada@example.com" },
  deceased: false,
  name: "Ada",
}));
if (nestedRecord.contact.email !== "ada@example.com" || nestedRecord.contact.phone !== undefined) {
  throw new Error("nested optional record did not round-trip");
}

const nullNestedRecord = decodeRecordTest2({
  age: 36,
  contact: { email: null, phone: null },
  deceased: false,
  name: "Ada",
});
if (nullNestedRecord.contact.email !== undefined || nullNestedRecord.contact.phone !== undefined) {
  throw new Error("null nested optional fields were not absent");
}

const omittedOptionalRecord = decodeRecordTest3(encodeRecordTest3({ name: "Ada" }));
if (omittedOptionalRecord.age !== undefined || omittedOptionalRecord.deceased !== undefined) {
  throw new Error("omitted optional record fields changed");
}
const presentOptionalRecord = decodeRecordTest3(encodeRecordTest3({ age: 36, deceased: false, name: "Ada" }));
if (presentOptionalRecord.age !== 36 || presentOptionalRecord.deceased !== false) {
  throw new Error("present optional record fields changed");
}
const nullOptionalRecord = decodeRecordTest3({ age: null, deceased: null, name: "Ada" });
if (nullOptionalRecord.age !== undefined || nullOptionalRecord.deceased !== undefined) {
  throw new Error("null optional record fields were not absent");
}

const interfaceRecord = decodeRecordTest4(encodeRecordTest4({ id: "person-1", status: "active" }));
if (interfaceRecord.id !== "person-1" || interfaceRecord.status !== "active" || interfaceRecord.age !== undefined) {
  throw new Error("interface record did not round-trip");
}
if (decodeRecordTest4({ id: "person-1", status: "active", age: null }).age !== undefined) {
  throw new Error("null interface optional field was not absent");
}

const instant = new Date("2026-07-25T14:30:00.123Z");
const decodedInstant = decodeTimeTest0(encodeTimeTest0(instant));
if (!(decodedInstant instanceof Date) || decodedInstant.toISOString() !== instant.toISOString()) {
  throw new Error("instant did not round-trip");
}
if (decodeTimeTest1(encodeTimeTest1(instant)).toISOString() !== instant.toISOString()) {
  throw new Error("described instant did not round-trip");
}

const calendarDate = new Date("1815-12-10T00:00:00.000Z");
const decodedCalendarDate = decodeTimeTest2(encodeTimeTest2(calendarDate));
if (!(decodedCalendarDate instanceof Date) || decodedCalendarDate.toISOString().slice(0, 10) !== "1815-12-10") {
  throw new Error("calendar date did not round-trip");
}
if (decodeTimeTest3(encodeTimeTest3("14:30:00.123")) !== "14:30:00.123") {
  throw new Error("local time did not round-trip");
}
if (decodeTimeTest4(encodeTimeTest4("P1Y2M3DT4H5M6S")) !== "P1Y2M3DT4H5M6S") {
  throw new Error("duration did not round-trip");
}
expectCodecError(() => encodeTimeTest0(new Date("invalid")));
expectCodecError(() => decodeTimeTest0("not-an-instant"));
expectCodecError(() => decodeTimeTest2("not-a-date"));
expectCodecError(() => decodeTimeTest3("not-a-time"));
expectCodecError(() => decodeTimeTest4("not-a-duration"));

const anyValue = {
  active: true,
  nested: { count: 2, text: "nested" },
  values: [null, "text", 3],
};
const encodedAny = encodeAnyTest0(anyValue);
if (encodedAny !== anyValue) throw new Error("any encoding copied the JSON tree");
const decodedAny = decodeAnyTest0(encodedAny);
if (decodedAny !== encodedAny) throw new Error("any decoding copied the JSON tree");

const permissiveAny = decodeAnyTest1(encodeAnyTest1({ value: ["permissive"] }));
if (permissiveAny.value[0] !== "permissive") throw new Error("permissive any did not round-trip");

expectCodecError(() => encodeAnyTest0(undefined));
expectCodecError(() => encodeAnyTest0(() => undefined));
expectCodecError(() => encodeAnyTest0(Number.NaN));
expectCodecError(() => decodeAnyTest0(Number.POSITIVE_INFINITY));
expectCodecError(() => encodeAnyTest0(new Date()));
expectCodecError(() => encodeAnyTest0(new Map()));

const referencedPerson = { age: 36, deceased: false, name: "Ada" };
const decodedPerson = decodePerson(encodePerson(referencedPerson));
if (decodedPerson.name !== "Ada" || decodedPerson.age !== 36 || decodedPerson.deceased !== false) {
  throw new Error("referenced person did not round-trip");
}

const encodedPeople = encodePeople([referencedPerson, { age: 85, deceased: true, name: "Grace" }]);
if (!Array.isArray(encodedPeople) || encodedPeople[0] === null || typeof encodedPeople[0] !== "object") {
  throw new Error("people did not encode as nested objects");
}
const decodedPeople = decodePeople(encodedPeople);
if (decodedPeople[1]?.name !== "Grace") throw new Error("people did not round-trip");
expectCodecError(() => decodePeople([{ age: 36, deceased: false }]));

if (decodeOneOfTest0(encodeOneOfTest0("text value")) !== "text value") {
  throw new Error("text OneOf option did not round-trip");
}
if (decodeOneOfTest0(encodeOneOfTest0(42)) !== 42) {
  throw new Error("natural OneOf option did not round-trip");
}
if (decodeOneOfTest1(encodeOneOfTest1(7)) !== 7) {
  throw new Error("described OneOf option did not round-trip");
}
const oneOfRecord = decodeOneOfTest2(encodeOneOfTest2({ bar: 1, foo: "details" }));
if (typeof oneOfRecord === "string" || typeof oneOfRecord === "number" || oneOfRecord.foo !== "details") {
  throw new Error("record OneOf option did not round-trip");
}
if (decodeOneOfTest3(encodeOneOfTest3("foo")) !== "foo") {
  throw new Error("reference OneOf option did not round-trip");
}
expectCodecError(() => decodeOneOfTest0(-1));

const overlappingRecord = { bar: 1, foo: "overlap" };
const encodedExtendedFirst = encodeOneOfTest4(overlappingRecord);
if (encodedExtendedFirst === null || typeof encodedExtendedFirst !== "object" || Array.isArray(encodedExtendedFirst)) {
  throw new Error("extended-first OneOf did not encode as an object");
}
if (encodedExtendedFirst.bar !== 1 || encodedExtendedFirst.foo !== "overlap") {
  throw new Error("extended-first OneOf dropped the extended field");
}
const decodedExtendedFirst = decodeOneOfTest4(encodedExtendedFirst);
if (!("bar" in decodedExtendedFirst) || decodedExtendedFirst.bar !== 1) {
  throw new Error("extended-first OneOf did not select the extended record");
}

const encodedBaseFirst = encodeOneOfTest5(overlappingRecord);
if (encodedBaseFirst === null || typeof encodedBaseFirst !== "object" || Array.isArray(encodedBaseFirst)) {
  throw new Error("base-first OneOf did not encode as an object");
}
if ("bar" in encodedBaseFirst || encodedBaseFirst.foo !== "overlap") {
  throw new Error("base-first OneOf did not select the base record");
}
const decodedBaseFirst = decodeOneOfTest5(encodedBaseFirst);
if ("bar" in decodedBaseFirst || decodedBaseFirst.foo !== "overlap") {
  throw new Error("base-first OneOf did not preserve first-match behavior");
}
