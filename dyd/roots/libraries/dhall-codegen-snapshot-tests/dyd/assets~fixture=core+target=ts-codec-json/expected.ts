
/** boolean test 0 */
export type BooleanTest0 =
	boolean;


/** boolean test 1 */
export type BooleanTest1 =
	/** comment */
	boolean;


/** boolean test 2 */
export type BooleanTest2 =
	/** multi-line
	comment */
	boolean;


/** number test 0 */
export type NumberTest0 =
	number;


/** number test 1 */
export type NumberTest1 =
	/** number */
	number;


/** number test 2 */
export type NumberTest2 =
	/** natural */
	number;


/** number test 3 */
export type NumberTest3 =
	/** integer */
	number;


/** number test 4 */
export type NumberTest4 =
	/** decimal */
	number;


/** text test 0 */
export type TextTest0 =
	string;


/** text test 1 */
export type TextTest1 =
	/** text */
	string;


/** text test 2 */
export type TextTest2 =
	/** email */
	string;


/** text test 3 */
export type TextTest3 =
	/** url */
	string;


/** text test 4 */
export type TextTest4 =
	/** text literal */
	"foo";


/** text test 5 */
export type TextTest5 =
	/** RFC 3339 date-time */
	string;


/** text test 6 */
export type TextTest6 =
	/** ISO 8601 calendar date */
	string;


/** text test 7 */
export type TextTest7 =
	/** ISO 8601 local time */
	string;


/** text test 8 */
export type TextTest8 =
	/** ISO 8601 duration */
	string;


/** text test 9 */
export type TextTest9 =
	/** RFC 4122 UUID */
	string;


/** text test 10 */
export type TextTest10 =
	/** IPv4 address */
	string;


/** text test 11 */
export type TextTest11 =
	/** IPv6 address */
	string;


/** text test 12 */
export type TextTest12 =
	/** RFC 4648 Base64 */
	string;


/** text test 13 */
export type TextTest13 =
	/** RFC 4648 Base64url */
	string;


/** text test 14 */
export type TextTest14 =
	/** E.164 telephone number */
	string;


/** optional test 0 */
export type OptionalTest0 =
	(
		string
		| undefined
	);

export type OptionalTest1Value =
	{
		foo :
			string;
	};


/** optional test 1 */
export type OptionalTest1 =
	(
		OptionalTest1Value
		| undefined
	);


/** optional test 2 */
export type OptionalTest2 =
	(
		string
		| undefined
	);


/** list test 0 */
export type ListTest0 =
	/** a list */
	Array<
		string
	>;


/** list test 1 */
export type ListTest1 =
	/** a list */
	Array<
		/** a list inside a list */
		Array<
			string
		>
	>;

export type ListTest2Values =
	/** a record inside a list */
	{
		foo :
			string;
	};


/** list test 2 */
export type ListTest2 =
	/** a list */
	Array<
		/** a record inside a list */
		ListTest2Values
	>;


/** tuple test 0 */
export type TupleTest0 =
	[
		string,
		number
	];


/** tuple test 1 */
export type TupleTest1 =
	/** a tuple */
	[
		string,
		number
	];


/** tuple test 2 */
export type TupleTest2 =
	/** a tuple */
	[
		string,
		/** a tuple in a tuple */
		[
			string,
			number
		]
	];


/** set test 0 */
export type SetTest0 =
	/** a set */
	Set<
		string
	>;


/** set test 1 */
export type SetTest1 =
	/** a set-like list */
	Array<
		string
	>;


/** set test 2 */
export type SetTest2 =
	/** a set */
	Set<
		/** a set inside a set */
		Set<
			string
		>
	>;

export type SetTest3Values =
	/** a record inside a set */
	{
		foo :
			string;
	};


/** set test 3 */
export type SetTest3 =
	/** a set */
	Set<
		/** a record inside a set */
		SetTest3Values
	>;


/** map test 0 */
export type MapTest0 =
	/** a map */
	Map<
		string,
		string
	>;


/** map test 1 */
export type MapTest1 =
	/** a map-like record */
	Record<
		string,
		string
	>;


/** map test 2 */
export type MapTest2 =
	/** a map */
	Map<
		string,
		/** a map inside a map */
		Map<
			string,
			string
		>
	>;

export type MapTest3Keys =
	/** a keys record inside a map */
	{
		foo :
			string;
	};

export type MapTest3Values =
	/** a values record inside a map */
	{
		foo :
			string;
	};


/** map test 3 */
export type MapTest3 =
	/** a map */
	Map<
		/** a keys record inside a map */
		MapTest3Keys,
		/** a values record inside a map */
		MapTest3Values
	>;


/** record test 0 */
export type RecordTest0 =
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};


/** record test 1 */
export type RecordTest1 =
	/** a record */
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};

export type RecordTest2Contact =
	{
		email ?:
			string;
		phone ?:
			string;
	};


/** record test 2 */
export type RecordTest2 =
	/** a record with an embedded record */
	{
		age :
			number;
		contact :
			RecordTest2Contact;
		deceased :
			boolean;
		name :
			string;
	};


/** record test 3 */
export type RecordTest3 =
	/** a record with optional props */
	{
		name :
			string;
		age ?:
			number;
		deceased ?:
			boolean;
	};


/** record test 4 */
export type RecordTest4 =
	{
		id :
			string;
		status :
			string;
		age ?:
			number;
	};


/** time test 0 */
export type TimeTest0 =
	Date;


/** time test 1 */
export type TimeTest1 =
	/** comment */
	Date;


/** time test 2 */
export type TimeTest2 =
	/** calendar date */
	Date;


/** time test 3 */
export type TimeTest3 =
	/** local time */
	string;


/** time test 4 */
export type TimeTest4 =
	/** ISO 8601 duration */
	string;


/** any test 0 */
export type AnyTest0 =
	unknown;


/** any test 1 */
export type AnyTest1 =
	any;


/** any test 2 */
export type AnyTest2 =
	/** comment */
	unknown;


/** any test 3 */
export type AnyTest3 =
	/** multi-line
	comment */
	unknown;

export type Person =
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};

export type People =
	Array<
		/** reference to person type */
		Person
	>;


/** oneOf test 0 */
export type OneOfTest0 =
	(
		string |
		number
	);


/** oneOf test 1 */
export type OneOfTest1 =
	/** number or string */
	(
		string |
		number
	);

export type OneOfTest2Option2 =
	{
		bar :
			number;
		foo :
			string;
	};


/** oneOf test 2 */
export type OneOfTest2 =
	/** number or string or record */
	(
		string |
		number |
		OneOfTest2Option2
	);


/** oneOf test 3 */
export type OneOfTest3 =
	/** named references */
	(
		Foo |
		Bar
	);

export type OneOfTest4Option0 =
	{
		bar :
			number;
		foo :
			string;
	};

export type OneOfTest4Option1 =
	{
		foo :
			string;
	};


/** oneOf test 4 */
export type OneOfTest4 =
	/** extended record before base record */
	(
		OneOfTest4Option0 |
		OneOfTest4Option1
	);

export type OneOfTest5Option0 =
	{
		foo :
			string;
	};

export type OneOfTest5Option1 =
	{
		bar :
			number;
		foo :
			string;
	};


/** oneOf test 5 */
export type OneOfTest5 =
	/** base record before extended record */
	(
		OneOfTest5Option0 |
		OneOfTest5Option1
	);

export type Foo =
	string;

export type Bar =
	number;

export type JsonValue =
  | null
  | boolean
  | number
  | string
  | JsonValue[]
  | { [key: string]: JsonValue };

export class CodecError extends Error {
  constructor(
    public readonly operation: "encode" | "decode",
    public readonly path: string,
    message: string,
  ) {
    super(operation + " error at " + path + ": " + message);
    this.name = "CodecError";
  }
}

export class UnsupportedCodecError extends CodecError {
  constructor(operation: "encode" | "decode", path: string, schema: string) {
    super(operation, path, "unsupported schema " + schema);
    this.name = "UnsupportedCodecError";
  }
}

const hasOwn = (value: object, key: string): boolean =>
  Object.prototype.hasOwnProperty.call(value, key);

const fail = (operation: "encode" | "decode", path: string, message: string): never => {
  throw new CodecError(operation, path, message);
};

const unsupported = (operation: "encode" | "decode", path: string, schema: string): never => {
  throw new UnsupportedCodecError(operation, path, schema);
};

const pathField = (path: string, field: string): string => path + "." + field;
const pathIndex = (path: string, index: number): string => path + "[" + index + "]";

const asObject = (operation: "encode" | "decode", value: unknown, path: string): Record<string, unknown> => {
  if (value === null || typeof value !== "object" || Array.isArray(value)) {
    return fail(operation, path, "expected object");
  }

  return value as Record<string, unknown>;
};

const asArray = (operation: "encode" | "decode", value: unknown, path: string): unknown[] => {
  if (!Array.isArray(value)) {
    return fail(operation, path, "expected array");
  }

  return value;
};

const asString = (operation: "encode" | "decode", value: unknown, path: string): string => {
  if (typeof value !== "string") {
    return fail(operation, path, "expected string");
  }

  return value;
};

const asNumber = (operation: "encode" | "decode", value: unknown, path: string): number => {
  if (typeof value !== "number" || !Number.isFinite(value)) {
    return fail(operation, path, "expected finite number");
  }

  return value;
};

const validateText = (variant: string, value: string, operation: "encode" | "decode", path: string): string => {
  const matches = (pattern: RegExp): boolean => pattern.test(value);

  if (variant.startsWith("literal:")) {
    const literal = variant.slice("literal:".length);
    return value === literal ? value : fail(operation, path, "expected literal " + JSON.stringify(literal));
  }

  switch (variant) {
    case "none": return value;
    case "email": return matches(/^[^@\s]+@[^@\s]+\.[^@\s]+$/) ? value : fail(operation, path, "expected email");
    case "url":
      try {
        new URL(value);
        return value;
      } catch {
        return fail(operation, path, "expected URL");
      }
    case "base64": return matches(/^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$/) ? value : fail(operation, path, "expected Base64");
    case "base64url": return matches(/^[A-Za-z0-9_-]*={0,2}$/) ? value : fail(operation, path, "expected Base64url");
    case "e164": return matches(/^\+[1-9][0-9]{1,14}$/) ? value : fail(operation, path, "expected E.164 phone number");
    case "ipv4": return matches(/^(?:25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})(?:\.(?:25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$/) ? value : fail(operation, path, "expected IPv4 address");
    case "ipv6": return value.includes(":") ? value : fail(operation, path, "expected IPv6 address");
    case "isoDate": return matches(/^\d{4}-\d{2}-\d{2}$/) ? value : fail(operation, path, "expected ISO date");
    case "isoDateTime": return matches(/^\d{4}-\d{2}-\d{2}T/) ? value : fail(operation, path, "expected RFC 3339 date-time");
    case "isoDuration": return matches(/^P(?=\d|T\d)/) ? value : fail(operation, path, "expected ISO duration");
    case "isoTime": return matches(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?$/) ? value : fail(operation, path, "expected local ISO time");
    case "uuid": return matches(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i) ? value : fail(operation, path, "expected UUID");
    default: return fail(operation, path, "unknown text variant " + variant);
  }
};

const asJsonObject = (operation: "encode" | "decode", value: unknown, path: string): Record<string, unknown> => {
  const object = asObject(operation, value, path);
  const prototype = Object.getPrototypeOf(object);

  if (prototype !== Object.prototype && prototype !== null) {
    return fail(operation, path, "expected plain object");
  }

  return object;
};

const validateAny = (operation: "encode" | "decode", value: unknown, path: string): JsonValue => {
  if (value === null || typeof value === "boolean" || typeof value === "string") return value as null | boolean | string;
  if (typeof value === "number") return asNumber(operation, value, path);
  if (Array.isArray(value)) {
    for (let index = 0; index < value.length; index += 1) {
      validateAny(operation, value[index], pathIndex(path, index));
    }
    return value as JsonValue[];
  }

  const object = asJsonObject(operation, value, path);
  for (const key in object) {
    if (hasOwn(object, key)) validateAny(operation, object[key], pathField(path, key));
  }
  return object as { [key: string]: JsonValue };
};

const encodeAny = (value: unknown, path: string): JsonValue => validateAny("encode", value, path);

const decodeAny = (value: unknown, path: string): JsonValue => validateAny("decode", value, path);

const encodeBoolean = (value: unknown, path: string): JsonValue =>
  typeof value === "boolean" ? value : fail("encode", path, "expected boolean");

const decodeBoolean = (value: unknown, path: string): boolean =>
  typeof value === "boolean" ? value : fail("decode", path, "expected boolean");

const encodeNumber = (variant: string, value: unknown, path: string): JsonValue => {
  const number = asNumber("encode", value, path);
  if (variant === "natural" && (!Number.isInteger(number) || number < 0)) fail("encode", path, "expected natural number");
  if (variant === "integer" && !Number.isInteger(number)) fail("encode", path, "expected integer");
  return number;
};

const decodeNumber = (variant: string, value: unknown, path: string): number => {
  const number = asNumber("decode", value, path);
  if (variant === "natural" && (!Number.isInteger(number) || number < 0)) fail("decode", path, "expected natural number");
  if (variant === "integer" && !Number.isInteger(number)) fail("decode", path, "expected integer");
  return number;
};

const encodeText = (variant: string, value: unknown, path: string): JsonValue =>
  validateText(variant, asString("encode", value, path), "encode", path);

const decodeText = (variant: string, value: unknown, path: string): string =>
  validateText(variant, asString("decode", value, path), "decode", path);

const encodeTime = (variant: string, value: unknown, path: string): JsonValue => {
  if (variant === "none" || variant === "date") {
    if (!(value instanceof Date) || Number.isNaN(value.getTime())) return fail("encode", path, "expected valid Date");
    return variant === "date" ? value.toISOString().slice(0, 10) : value.toISOString();
  }

  return validateText(variant === "time" ? "isoTime" : "isoDuration", asString("encode", value, path), "encode", path);
};

const decodeTime = (variant: string, value: unknown, path: string): unknown => {
  const text = asString("decode", value, path);
  const textVariant = variant === "none" ? "isoDateTime" : variant === "date" ? "isoDate" : variant === "time" ? "isoTime" : "isoDuration";
  validateText(textVariant, text, "decode", path);

  if (variant === "none") {
    const result = new Date(text);
    return Number.isNaN(result.getTime()) ? fail("decode", path, "invalid date-time") : result;
  }

  if (variant === "date") return new Date(text + "T00:00:00.000Z");
  return text;
};



function encodeBooleanTest0At(value: BooleanTest0, path: string): JsonValue {
	return encodeBoolean(value, path);}

function decodeBooleanTest0At(input: unknown, path: string): BooleanTest0 {
	return decodeBoolean(input, path) as BooleanTest0;}

export function encodeBooleanTest0(value: BooleanTest0): JsonValue {
	return encodeBooleanTest0At(value, "$");
}

export function decodeBooleanTest0(input: unknown): BooleanTest0 {
	return decodeBooleanTest0At(input, "$");
}

function encodeBooleanTest1At(value: BooleanTest1, path: string): JsonValue {
	return encodeBoolean(value, path);}

function decodeBooleanTest1At(input: unknown, path: string): BooleanTest1 {
	return decodeBoolean(input, path) as BooleanTest1;}

export function encodeBooleanTest1(value: BooleanTest1): JsonValue {
	return encodeBooleanTest1At(value, "$");
}

export function decodeBooleanTest1(input: unknown): BooleanTest1 {
	return decodeBooleanTest1At(input, "$");
}

function encodeBooleanTest2At(value: BooleanTest2, path: string): JsonValue {
	return encodeBoolean(value, path);}

function decodeBooleanTest2At(input: unknown, path: string): BooleanTest2 {
	return decodeBoolean(input, path) as BooleanTest2;}

export function encodeBooleanTest2(value: BooleanTest2): JsonValue {
	return encodeBooleanTest2At(value, "$");
}

export function decodeBooleanTest2(input: unknown): BooleanTest2 {
	return decodeBooleanTest2At(input, "$");
}

function encodeNumberTest0At(value: NumberTest0, path: string): JsonValue {
	return encodeNumber("none", value, path);}

function decodeNumberTest0At(input: unknown, path: string): NumberTest0 {
	return decodeNumber("none", input, path) as NumberTest0;}

export function encodeNumberTest0(value: NumberTest0): JsonValue {
	return encodeNumberTest0At(value, "$");
}

export function decodeNumberTest0(input: unknown): NumberTest0 {
	return decodeNumberTest0At(input, "$");
}

function encodeNumberTest1At(value: NumberTest1, path: string): JsonValue {
	return encodeNumber("none", value, path);}

function decodeNumberTest1At(input: unknown, path: string): NumberTest1 {
	return decodeNumber("none", input, path) as NumberTest1;}

export function encodeNumberTest1(value: NumberTest1): JsonValue {
	return encodeNumberTest1At(value, "$");
}

export function decodeNumberTest1(input: unknown): NumberTest1 {
	return decodeNumberTest1At(input, "$");
}

function encodeNumberTest2At(value: NumberTest2, path: string): JsonValue {
	return encodeNumber("natural", value, path);}

function decodeNumberTest2At(input: unknown, path: string): NumberTest2 {
	return decodeNumber("natural", input, path) as NumberTest2;}

export function encodeNumberTest2(value: NumberTest2): JsonValue {
	return encodeNumberTest2At(value, "$");
}

export function decodeNumberTest2(input: unknown): NumberTest2 {
	return decodeNumberTest2At(input, "$");
}

function encodeNumberTest3At(value: NumberTest3, path: string): JsonValue {
	return encodeNumber("integer", value, path);}

function decodeNumberTest3At(input: unknown, path: string): NumberTest3 {
	return decodeNumber("integer", input, path) as NumberTest3;}

export function encodeNumberTest3(value: NumberTest3): JsonValue {
	return encodeNumberTest3At(value, "$");
}

export function decodeNumberTest3(input: unknown): NumberTest3 {
	return decodeNumberTest3At(input, "$");
}

function encodeNumberTest4At(value: NumberTest4, path: string): JsonValue {
	return encodeNumber("decimal", value, path);}

function decodeNumberTest4At(input: unknown, path: string): NumberTest4 {
	return decodeNumber("decimal", input, path) as NumberTest4;}

export function encodeNumberTest4(value: NumberTest4): JsonValue {
	return encodeNumberTest4At(value, "$");
}

export function decodeNumberTest4(input: unknown): NumberTest4 {
	return decodeNumberTest4At(input, "$");
}

function encodeTextTest0At(value: TextTest0, path: string): JsonValue {
	return encodeText("none", value, path);}

function decodeTextTest0At(input: unknown, path: string): TextTest0 {
	return decodeText("none", input, path) as TextTest0;}

export function encodeTextTest0(value: TextTest0): JsonValue {
	return encodeTextTest0At(value, "$");
}

export function decodeTextTest0(input: unknown): TextTest0 {
	return decodeTextTest0At(input, "$");
}

function encodeTextTest1At(value: TextTest1, path: string): JsonValue {
	return encodeText("none", value, path);}

function decodeTextTest1At(input: unknown, path: string): TextTest1 {
	return decodeText("none", input, path) as TextTest1;}

export function encodeTextTest1(value: TextTest1): JsonValue {
	return encodeTextTest1At(value, "$");
}

export function decodeTextTest1(input: unknown): TextTest1 {
	return decodeTextTest1At(input, "$");
}

function encodeTextTest2At(value: TextTest2, path: string): JsonValue {
	return encodeText("email", value, path);}

function decodeTextTest2At(input: unknown, path: string): TextTest2 {
	return decodeText("email", input, path) as TextTest2;}

export function encodeTextTest2(value: TextTest2): JsonValue {
	return encodeTextTest2At(value, "$");
}

export function decodeTextTest2(input: unknown): TextTest2 {
	return decodeTextTest2At(input, "$");
}

function encodeTextTest3At(value: TextTest3, path: string): JsonValue {
	return encodeText("url", value, path);}

function decodeTextTest3At(input: unknown, path: string): TextTest3 {
	return decodeText("url", input, path) as TextTest3;}

export function encodeTextTest3(value: TextTest3): JsonValue {
	return encodeTextTest3At(value, "$");
}

export function decodeTextTest3(input: unknown): TextTest3 {
	return decodeTextTest3At(input, "$");
}

function encodeTextTest4At(value: TextTest4, path: string): JsonValue {
	return encodeText("literal:foo", value, path);}

function decodeTextTest4At(input: unknown, path: string): TextTest4 {
	return decodeText("literal:foo", input, path) as TextTest4;}

export function encodeTextTest4(value: TextTest4): JsonValue {
	return encodeTextTest4At(value, "$");
}

export function decodeTextTest4(input: unknown): TextTest4 {
	return decodeTextTest4At(input, "$");
}

function encodeTextTest5At(value: TextTest5, path: string): JsonValue {
	return encodeText("isoDateTime", value, path);}

function decodeTextTest5At(input: unknown, path: string): TextTest5 {
	return decodeText("isoDateTime", input, path) as TextTest5;}

export function encodeTextTest5(value: TextTest5): JsonValue {
	return encodeTextTest5At(value, "$");
}

export function decodeTextTest5(input: unknown): TextTest5 {
	return decodeTextTest5At(input, "$");
}

function encodeTextTest6At(value: TextTest6, path: string): JsonValue {
	return encodeText("isoDate", value, path);}

function decodeTextTest6At(input: unknown, path: string): TextTest6 {
	return decodeText("isoDate", input, path) as TextTest6;}

export function encodeTextTest6(value: TextTest6): JsonValue {
	return encodeTextTest6At(value, "$");
}

export function decodeTextTest6(input: unknown): TextTest6 {
	return decodeTextTest6At(input, "$");
}

function encodeTextTest7At(value: TextTest7, path: string): JsonValue {
	return encodeText("isoTime", value, path);}

function decodeTextTest7At(input: unknown, path: string): TextTest7 {
	return decodeText("isoTime", input, path) as TextTest7;}

export function encodeTextTest7(value: TextTest7): JsonValue {
	return encodeTextTest7At(value, "$");
}

export function decodeTextTest7(input: unknown): TextTest7 {
	return decodeTextTest7At(input, "$");
}

function encodeTextTest8At(value: TextTest8, path: string): JsonValue {
	return encodeText("isoDuration", value, path);}

function decodeTextTest8At(input: unknown, path: string): TextTest8 {
	return decodeText("isoDuration", input, path) as TextTest8;}

export function encodeTextTest8(value: TextTest8): JsonValue {
	return encodeTextTest8At(value, "$");
}

export function decodeTextTest8(input: unknown): TextTest8 {
	return decodeTextTest8At(input, "$");
}

function encodeTextTest9At(value: TextTest9, path: string): JsonValue {
	return encodeText("uuid", value, path);}

function decodeTextTest9At(input: unknown, path: string): TextTest9 {
	return decodeText("uuid", input, path) as TextTest9;}

export function encodeTextTest9(value: TextTest9): JsonValue {
	return encodeTextTest9At(value, "$");
}

export function decodeTextTest9(input: unknown): TextTest9 {
	return decodeTextTest9At(input, "$");
}

function encodeTextTest10At(value: TextTest10, path: string): JsonValue {
	return encodeText("ipv4", value, path);}

function decodeTextTest10At(input: unknown, path: string): TextTest10 {
	return decodeText("ipv4", input, path) as TextTest10;}

export function encodeTextTest10(value: TextTest10): JsonValue {
	return encodeTextTest10At(value, "$");
}

export function decodeTextTest10(input: unknown): TextTest10 {
	return decodeTextTest10At(input, "$");
}

function encodeTextTest11At(value: TextTest11, path: string): JsonValue {
	return encodeText("ipv6", value, path);}

function decodeTextTest11At(input: unknown, path: string): TextTest11 {
	return decodeText("ipv6", input, path) as TextTest11;}

export function encodeTextTest11(value: TextTest11): JsonValue {
	return encodeTextTest11At(value, "$");
}

export function decodeTextTest11(input: unknown): TextTest11 {
	return decodeTextTest11At(input, "$");
}

function encodeTextTest12At(value: TextTest12, path: string): JsonValue {
	return encodeText("base64", value, path);}

function decodeTextTest12At(input: unknown, path: string): TextTest12 {
	return decodeText("base64", input, path) as TextTest12;}

export function encodeTextTest12(value: TextTest12): JsonValue {
	return encodeTextTest12At(value, "$");
}

export function decodeTextTest12(input: unknown): TextTest12 {
	return decodeTextTest12At(input, "$");
}

function encodeTextTest13At(value: TextTest13, path: string): JsonValue {
	return encodeText("base64url", value, path);}

function decodeTextTest13At(input: unknown, path: string): TextTest13 {
	return decodeText("base64url", input, path) as TextTest13;}

export function encodeTextTest13(value: TextTest13): JsonValue {
	return encodeTextTest13At(value, "$");
}

export function decodeTextTest13(input: unknown): TextTest13 {
	return decodeTextTest13At(input, "$");
}

function encodeTextTest14At(value: TextTest14, path: string): JsonValue {
	return encodeText("e164", value, path);}

function decodeTextTest14At(input: unknown, path: string): TextTest14 {
	return decodeText("e164", input, path) as TextTest14;}

export function encodeTextTest14(value: TextTest14): JsonValue {
	return encodeTextTest14At(value, "$");
}

export function decodeTextTest14(input: unknown): TextTest14 {
	return decodeTextTest14At(input, "$");
}

function encodeOptionalTest0At(value: OptionalTest0, path: string): JsonValue {
	return value === undefined || value === null ? null : encodeText("none", value, path);}

function decodeOptionalTest0At(input: unknown, path: string): OptionalTest0 {
	return input === null ? undefined : decodeText("none", input, path) as OptionalTest0;}

export function encodeOptionalTest0(value: OptionalTest0): JsonValue {
	return encodeOptionalTest0At(value, "$");
}

export function decodeOptionalTest0(input: unknown): OptionalTest0 {
	return decodeOptionalTest0At(input, "$");
}

function encodeOptionalTest1ValueAt(value: OptionalTest1Value, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOptionalTest1ValueAt(input: unknown, path: string): OptionalTest1Value {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OptionalTest1Value;
}

export function encodeOptionalTest1Value(value: OptionalTest1Value): JsonValue {
	return encodeOptionalTest1ValueAt(value, "$");
}

export function decodeOptionalTest1Value(input: unknown): OptionalTest1Value {
	return decodeOptionalTest1ValueAt(input, "$");
}

function encodeOptionalTest1At(value: OptionalTest1, path: string): JsonValue {
	return value === undefined || value === null ? null : encodeOptionalTest1ValueAt(value as OptionalTest1Value, path);}

function decodeOptionalTest1At(input: unknown, path: string): OptionalTest1 {
	return input === null ? undefined : decodeOptionalTest1ValueAt(input, path) as OptionalTest1;}

export function encodeOptionalTest1(value: OptionalTest1): JsonValue {
	return encodeOptionalTest1At(value, "$");
}

export function decodeOptionalTest1(input: unknown): OptionalTest1 {
	return decodeOptionalTest1At(input, "$");
}

function encodeOptionalTest2At(value: OptionalTest2, path: string): JsonValue {
	return value === undefined || value === null ? null : encodeText("none", value, path);}

function decodeOptionalTest2At(input: unknown, path: string): OptionalTest2 {
	return input === null ? undefined : decodeText("none", input, path) as OptionalTest2;}

export function encodeOptionalTest2(value: OptionalTest2): JsonValue {
	return encodeOptionalTest2At(value, "$");
}

export function decodeOptionalTest2(input: unknown): OptionalTest2 {
	return decodeOptionalTest2At(input, "$");
}

function encodeListTest0At(value: ListTest0, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = encodeText("none", entries[index], pathIndex(path, index));
		}
		return result;
	})(value, path);}

function decodeListTest0At(input: unknown, path: string): ListTest0 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = decodeText("none", entries[index], pathIndex(path, index));
		}
		return result;
	})(input, path) as ListTest0;}

export function encodeListTest0(value: ListTest0): JsonValue {
	return encodeListTest0At(value, "$");
}

export function decodeListTest0(input: unknown): ListTest0 {
	return decodeListTest0At(input, "$");
}

function encodeListTest1At(value: ListTest1, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = ((input: unknown, path: string): JsonValue[] => {
				const entries = asArray("encode", input, path);
				const result: JsonValue[] = new Array(entries.length);
				for (let index = 0; index < entries.length; index += 1) {
					result[index] = encodeText("none", entries[index], pathIndex(path, index));
				}
				return result;
			})(entries[index], pathIndex(path, index));
		}
		return result;
	})(value, path);}

function decodeListTest1At(input: unknown, path: string): ListTest1 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = ((input: unknown, path: string): unknown[] => {
				const entries = asArray("decode", input, path);
				const result: unknown[] = new Array(entries.length);
				for (let index = 0; index < entries.length; index += 1) {
					result[index] = decodeText("none", entries[index], pathIndex(path, index));
				}
				return result;
			})(entries[index], pathIndex(path, index));
		}
		return result;
	})(input, path) as ListTest1;}

export function encodeListTest1(value: ListTest1): JsonValue {
	return encodeListTest1At(value, "$");
}

export function decodeListTest1(input: unknown): ListTest1 {
	return decodeListTest1At(input, "$");
}

function encodeListTest2ValuesAt(value: ListTest2Values, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeListTest2ValuesAt(input: unknown, path: string): ListTest2Values {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as ListTest2Values;
}

export function encodeListTest2Values(value: ListTest2Values): JsonValue {
	return encodeListTest2ValuesAt(value, "$");
}

export function decodeListTest2Values(input: unknown): ListTest2Values {
	return decodeListTest2ValuesAt(input, "$");
}

function encodeListTest2At(value: ListTest2, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = encodeListTest2ValuesAt(entries[index] as ListTest2Values, pathIndex(path, index));
		}
		return result;
	})(value, path);}

function decodeListTest2At(input: unknown, path: string): ListTest2 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = decodeListTest2ValuesAt(entries[index], pathIndex(path, index));
		}
		return result;
	})(input, path) as ListTest2;}

export function encodeListTest2(value: ListTest2): JsonValue {
	return encodeListTest2At(value, "$");
}

export function decodeListTest2(input: unknown): ListTest2 {
	return decodeListTest2At(input, "$");
}

function encodeTupleTest0At(value: TupleTest0, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		if (entries.length !== 2) fail("encode", path, "expected tuple of length 2");
		return [encodeText("none", entries[0], pathIndex(path, 0)), encodeNumber("natural", entries[1], pathIndex(path, 1))];
	})(value, path);}

function decodeTupleTest0At(input: unknown, path: string): TupleTest0 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		if (entries.length !== 2) fail("decode", path, "expected tuple of length 2");
		return [decodeText("none", entries[0], pathIndex(path, 0)), decodeNumber("natural", entries[1], pathIndex(path, 1))];
	})(input, path) as TupleTest0;}

export function encodeTupleTest0(value: TupleTest0): JsonValue {
	return encodeTupleTest0At(value, "$");
}

export function decodeTupleTest0(input: unknown): TupleTest0 {
	return decodeTupleTest0At(input, "$");
}

function encodeTupleTest1At(value: TupleTest1, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		if (entries.length !== 2) fail("encode", path, "expected tuple of length 2");
		return [encodeText("none", entries[0], pathIndex(path, 0)), encodeNumber("natural", entries[1], pathIndex(path, 1))];
	})(value, path);}

function decodeTupleTest1At(input: unknown, path: string): TupleTest1 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		if (entries.length !== 2) fail("decode", path, "expected tuple of length 2");
		return [decodeText("none", entries[0], pathIndex(path, 0)), decodeNumber("natural", entries[1], pathIndex(path, 1))];
	})(input, path) as TupleTest1;}

export function encodeTupleTest1(value: TupleTest1): JsonValue {
	return encodeTupleTest1At(value, "$");
}

export function decodeTupleTest1(input: unknown): TupleTest1 {
	return decodeTupleTest1At(input, "$");
}

function encodeTupleTest2At(value: TupleTest2, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		if (entries.length !== 2) fail("encode", path, "expected tuple of length 2");
		return [encodeText("none", entries[0], pathIndex(path, 0)), ((input: unknown, path: string): JsonValue[] => {
			const entries = asArray("encode", input, path);
			if (entries.length !== 2) fail("encode", path, "expected tuple of length 2");
			return [encodeText("none", entries[0], pathIndex(path, 0)), encodeNumber("natural", entries[1], pathIndex(path, 1))];
		})(entries[1], pathIndex(path, 1))];
	})(value, path);}

function decodeTupleTest2At(input: unknown, path: string): TupleTest2 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		if (entries.length !== 2) fail("decode", path, "expected tuple of length 2");
		return [decodeText("none", entries[0], pathIndex(path, 0)), ((input: unknown, path: string): unknown[] => {
			const entries = asArray("decode", input, path);
			if (entries.length !== 2) fail("decode", path, "expected tuple of length 2");
			return [decodeText("none", entries[0], pathIndex(path, 0)), decodeNumber("natural", entries[1], pathIndex(path, 1))];
		})(entries[1], pathIndex(path, 1))];
	})(input, path) as TupleTest2;}

export function encodeTupleTest2(value: TupleTest2): JsonValue {
	return encodeTupleTest2At(value, "$");
}

export function decodeTupleTest2(input: unknown): TupleTest2 {
	return decodeTupleTest2At(input, "$");
}

function encodeSetTest0At(value: SetTest0, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Set ? value : fail("encode", path, "expected Set");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = encodeText("none", entry, pathIndex(path, index));
			index += 1;
		}
		return result;
	})(value, path);}

function decodeSetTest0At(input: unknown, path: string): SetTest0 {
	return ((input: unknown, path: string): Set<unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Set<unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			result.add(decodeText("none", entries[index], pathIndex(path, index)));
		}
		return result;
	})(input, path) as SetTest0;}

export function encodeSetTest0(value: SetTest0): JsonValue {
	return encodeSetTest0At(value, "$");
}

export function decodeSetTest0(input: unknown): SetTest0 {
	return decodeSetTest0At(input, "$");
}

function encodeSetTest1At(value: SetTest1, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = encodeText("none", entries[index], pathIndex(path, index));
		}
		return result;
	})(value, path);}

function decodeSetTest1At(input: unknown, path: string): SetTest1 {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = decodeText("none", entries[index], pathIndex(path, index));
		}
		return result;
	})(input, path) as SetTest1;}

export function encodeSetTest1(value: SetTest1): JsonValue {
	return encodeSetTest1At(value, "$");
}

export function decodeSetTest1(input: unknown): SetTest1 {
	return decodeSetTest1At(input, "$");
}

function encodeSetTest2At(value: SetTest2, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Set ? value : fail("encode", path, "expected Set");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = ((value: unknown, path: string): JsonValue[] => {
				const entries = value instanceof Set ? value : fail("encode", path, "expected Set");
				const result: JsonValue[] = new Array(entries.size);
				let index = 0;
				for (const entry of entries) {
					result[index] = encodeText("none", entry, pathIndex(path, index));
					index += 1;
				}
				return result;
			})(entry, pathIndex(path, index));
			index += 1;
		}
		return result;
	})(value, path);}

function decodeSetTest2At(input: unknown, path: string): SetTest2 {
	return ((input: unknown, path: string): Set<unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Set<unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			result.add(((input: unknown, path: string): Set<unknown> => {
				const entries = asArray("decode", input, path);
				const result = new Set<unknown>();
				for (let index = 0; index < entries.length; index += 1) {
					result.add(decodeText("none", entries[index], pathIndex(path, index)));
				}
				return result;
			})(entries[index], pathIndex(path, index)));
		}
		return result;
	})(input, path) as SetTest2;}

export function encodeSetTest2(value: SetTest2): JsonValue {
	return encodeSetTest2At(value, "$");
}

export function decodeSetTest2(input: unknown): SetTest2 {
	return decodeSetTest2At(input, "$");
}

function encodeSetTest3ValuesAt(value: SetTest3Values, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeSetTest3ValuesAt(input: unknown, path: string): SetTest3Values {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as SetTest3Values;
}

export function encodeSetTest3Values(value: SetTest3Values): JsonValue {
	return encodeSetTest3ValuesAt(value, "$");
}

export function decodeSetTest3Values(input: unknown): SetTest3Values {
	return decodeSetTest3ValuesAt(input, "$");
}

function encodeSetTest3At(value: SetTest3, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Set ? value : fail("encode", path, "expected Set");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = encodeSetTest3ValuesAt(entry as SetTest3Values, pathIndex(path, index));
			index += 1;
		}
		return result;
	})(value, path);}

function decodeSetTest3At(input: unknown, path: string): SetTest3 {
	return ((input: unknown, path: string): Set<unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Set<unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			result.add(decodeSetTest3ValuesAt(entries[index], pathIndex(path, index)));
		}
		return result;
	})(input, path) as SetTest3;}

export function encodeSetTest3(value: SetTest3): JsonValue {
	return encodeSetTest3At(value, "$");
}

export function decodeSetTest3(input: unknown): SetTest3 {
	return decodeSetTest3At(input, "$");
}

function encodeMapTest0At(value: MapTest0, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Map ? value : fail("encode", path, "expected Map");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = { key: encodeText("none", entry[0], pathIndex(path, index)), value: encodeText("none", entry[1], pathIndex(path, index)) };
			index += 1;
		}
		return result;
	})(value, path);}

function decodeMapTest0At(input: unknown, path: string): MapTest0 {
	return ((input: unknown, path: string): Map<unknown, unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Map<unknown, unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			const entry = asObject("decode", entries[index], pathIndex(path, index));
			if (!hasOwn(entry, "key") || !hasOwn(entry, "value")) fail("decode", pathIndex(path, index), "expected map entry");
			result.set(decodeText("none", entry["key"], pathField(pathIndex(path, index), "key")), decodeText("none", entry["value"], pathField(pathIndex(path, index), "value")));
		}
		return result;
	})(input, path) as MapTest0;}

export function encodeMapTest0(value: MapTest0): JsonValue {
	return encodeMapTest0At(value, "$");
}

export function decodeMapTest0(input: unknown): MapTest0 {
	return decodeMapTest0At(input, "$");
}

function encodeMapTest1At(value: MapTest1, path: string): JsonValue {
	return ((input: unknown, path: string): { [key: string]: JsonValue } => {
		const object = asObject("encode", input, path);
		const result: { [key: string]: JsonValue } = {};
		for (const key in object) {
			if (!hasOwn(object, key)) continue;
			const wireKeyValue = encodeText("none", key, pathField(path, key));
			const wireKey = typeof wireKeyValue === "string" ? wireKeyValue : fail("encode", pathField(path, key), "record map keys must encode as strings");
			result[wireKey] = encodeText("none", object[key], pathField(path, key));
		}
		return result;
	})(value, path);}

function decodeMapTest1At(input: unknown, path: string): MapTest1 {
	return ((input: unknown, path: string): { [key: string]: unknown } => {
		const object = asObject("decode", input, path);
		const result: { [key: string]: unknown } = {};
		for (const key in object) {
			if (!hasOwn(object, key)) continue;
			const domainKeyValue = decodeText("none", key, pathField(path, key));
			const domainKey = typeof domainKeyValue === "string" ? domainKeyValue : fail("decode", pathField(path, key), "record map keys must decode as strings");
			result[domainKey] = decodeText("none", object[key], pathField(path, key));
		}
		return result;
	})(input, path) as MapTest1;}

export function encodeMapTest1(value: MapTest1): JsonValue {
	return encodeMapTest1At(value, "$");
}

export function decodeMapTest1(input: unknown): MapTest1 {
	return decodeMapTest1At(input, "$");
}

function encodeMapTest2At(value: MapTest2, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Map ? value : fail("encode", path, "expected Map");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = { key: encodeText("none", entry[0], pathIndex(path, index)), value: ((value: unknown, path: string): JsonValue[] => {
				const entries = value instanceof Map ? value : fail("encode", path, "expected Map");
				const result: JsonValue[] = new Array(entries.size);
				let index = 0;
				for (const entry of entries) {
					result[index] = { key: encodeText("none", entry[0], pathIndex(path, index)), value: encodeText("none", entry[1], pathIndex(path, index)) };
					index += 1;
				}
				return result;
			})(entry[1], pathIndex(path, index)) };
			index += 1;
		}
		return result;
	})(value, path);}

function decodeMapTest2At(input: unknown, path: string): MapTest2 {
	return ((input: unknown, path: string): Map<unknown, unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Map<unknown, unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			const entry = asObject("decode", entries[index], pathIndex(path, index));
			if (!hasOwn(entry, "key") || !hasOwn(entry, "value")) fail("decode", pathIndex(path, index), "expected map entry");
			result.set(decodeText("none", entry["key"], pathField(pathIndex(path, index), "key")), ((input: unknown, path: string): Map<unknown, unknown> => {
				const entries = asArray("decode", input, path);
				const result = new Map<unknown, unknown>();
				for (let index = 0; index < entries.length; index += 1) {
					const entry = asObject("decode", entries[index], pathIndex(path, index));
					if (!hasOwn(entry, "key") || !hasOwn(entry, "value")) fail("decode", pathIndex(path, index), "expected map entry");
					result.set(decodeText("none", entry["key"], pathField(pathIndex(path, index), "key")), decodeText("none", entry["value"], pathField(pathIndex(path, index), "value")));
				}
				return result;
			})(entry["value"], pathField(pathIndex(path, index), "value")));
		}
		return result;
	})(input, path) as MapTest2;}

export function encodeMapTest2(value: MapTest2): JsonValue {
	return encodeMapTest2At(value, "$");
}

export function decodeMapTest2(input: unknown): MapTest2 {
	return decodeMapTest2At(input, "$");
}

function encodeMapTest3KeysAt(value: MapTest3Keys, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeMapTest3KeysAt(input: unknown, path: string): MapTest3Keys {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as MapTest3Keys;
}

export function encodeMapTest3Keys(value: MapTest3Keys): JsonValue {
	return encodeMapTest3KeysAt(value, "$");
}

export function decodeMapTest3Keys(input: unknown): MapTest3Keys {
	return decodeMapTest3KeysAt(input, "$");
}

function encodeMapTest3ValuesAt(value: MapTest3Values, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeMapTest3ValuesAt(input: unknown, path: string): MapTest3Values {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as MapTest3Values;
}

export function encodeMapTest3Values(value: MapTest3Values): JsonValue {
	return encodeMapTest3ValuesAt(value, "$");
}

export function decodeMapTest3Values(input: unknown): MapTest3Values {
	return decodeMapTest3ValuesAt(input, "$");
}

function encodeMapTest3At(value: MapTest3, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue[] => {
		const entries = value instanceof Map ? value : fail("encode", path, "expected Map");
		const result: JsonValue[] = new Array(entries.size);
		let index = 0;
		for (const entry of entries) {
			result[index] = { key: encodeMapTest3KeysAt(entry[0] as MapTest3Keys, pathIndex(path, index)), value: encodeMapTest3ValuesAt(entry[1] as MapTest3Values, pathIndex(path, index)) };
			index += 1;
		}
		return result;
	})(value, path);}

function decodeMapTest3At(input: unknown, path: string): MapTest3 {
	return ((input: unknown, path: string): Map<unknown, unknown> => {
		const entries = asArray("decode", input, path);
		const result = new Map<unknown, unknown>();
		for (let index = 0; index < entries.length; index += 1) {
			const entry = asObject("decode", entries[index], pathIndex(path, index));
			if (!hasOwn(entry, "key") || !hasOwn(entry, "value")) fail("decode", pathIndex(path, index), "expected map entry");
			result.set(decodeMapTest3KeysAt(entry["key"], pathField(pathIndex(path, index), "key")), decodeMapTest3ValuesAt(entry["value"], pathField(pathIndex(path, index), "value")));
		}
		return result;
	})(input, path) as MapTest3;}

export function encodeMapTest3(value: MapTest3): JsonValue {
	return encodeMapTest3At(value, "$");
}

export function decodeMapTest3(input: unknown): MapTest3 {
	return decodeMapTest3At(input, "$");
}

function encodeRecordTest0At(value: RecordTest0, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = encodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	return result;
}

function decodeRecordTest0At(input: unknown, path: string): RecordTest0 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = decodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	return result as RecordTest0;
}

export function encodeRecordTest0(value: RecordTest0): JsonValue {
	return encodeRecordTest0At(value, "$");
}

export function decodeRecordTest0(input: unknown): RecordTest0 {
	return decodeRecordTest0At(input, "$");
}

function encodeRecordTest1At(value: RecordTest1, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = encodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	return result;
}

function decodeRecordTest1At(input: unknown, path: string): RecordTest1 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = decodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	return result as RecordTest1;
}

export function encodeRecordTest1(value: RecordTest1): JsonValue {
	return encodeRecordTest1At(value, "$");
}

export function decodeRecordTest1(input: unknown): RecordTest1 {
	return decodeRecordTest1At(input, "$");
}

function encodeRecordTest2ContactAt(value: RecordTest2Contact, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	if (hasOwn(object, "email") && object["email"] !== undefined) result["email"] = encodeText("none", object["email"], pathField(path, "email"));
	if (hasOwn(object, "phone") && object["phone"] !== undefined) result["phone"] = encodeText("none", object["phone"], pathField(path, "phone"));
	return result;
}

function decodeRecordTest2ContactAt(input: unknown, path: string): RecordTest2Contact {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	if (hasOwn(object, "email") && object["email"] !== null) result["email"] = decodeText("none", object["email"], pathField(path, "email"));
	if (hasOwn(object, "phone") && object["phone"] !== null) result["phone"] = decodeText("none", object["phone"], pathField(path, "phone"));
	return result as RecordTest2Contact;
}

export function encodeRecordTest2Contact(value: RecordTest2Contact): JsonValue {
	return encodeRecordTest2ContactAt(value, "$");
}

export function decodeRecordTest2Contact(input: unknown): RecordTest2Contact {
	return decodeRecordTest2ContactAt(input, "$");
}

function encodeRecordTest2At(value: RecordTest2, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	result["contact"] = encodeRecordTest2ContactAt(object["contact"] as RecordTest2Contact, pathField(path, "contact"));
	result["deceased"] = encodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	return result;
}

function decodeRecordTest2At(input: unknown, path: string): RecordTest2 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	result["contact"] = decodeRecordTest2ContactAt(object["contact"], pathField(path, "contact"));
	result["deceased"] = decodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	return result as RecordTest2;
}

export function encodeRecordTest2(value: RecordTest2): JsonValue {
	return encodeRecordTest2At(value, "$");
}

export function decodeRecordTest2(input: unknown): RecordTest2 {
	return decodeRecordTest2At(input, "$");
}

function encodeRecordTest3At(value: RecordTest3, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	if (hasOwn(object, "age") && object["age"] !== undefined) result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	if (hasOwn(object, "deceased") && object["deceased"] !== undefined) result["deceased"] = encodeBoolean(object["deceased"], pathField(path, "deceased"));
	return result;
}

function decodeRecordTest3At(input: unknown, path: string): RecordTest3 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	if (hasOwn(object, "age") && object["age"] !== null) result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	if (hasOwn(object, "deceased") && object["deceased"] !== null) result["deceased"] = decodeBoolean(object["deceased"], pathField(path, "deceased"));
	return result as RecordTest3;
}

export function encodeRecordTest3(value: RecordTest3): JsonValue {
	return encodeRecordTest3At(value, "$");
}

export function decodeRecordTest3(input: unknown): RecordTest3 {
	return decodeRecordTest3At(input, "$");
}

function encodeRecordTest4At(value: RecordTest4, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["id"] = encodeText("none", object["id"], pathField(path, "id"));
	result["status"] = encodeText("none", object["status"], pathField(path, "status"));
	if (hasOwn(object, "age") && object["age"] !== undefined) result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	return result;
}

function decodeRecordTest4At(input: unknown, path: string): RecordTest4 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["id"] = decodeText("none", object["id"], pathField(path, "id"));
	result["status"] = decodeText("none", object["status"], pathField(path, "status"));
	if (hasOwn(object, "age") && object["age"] !== null) result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	return result as RecordTest4;
}

export function encodeRecordTest4(value: RecordTest4): JsonValue {
	return encodeRecordTest4At(value, "$");
}

export function decodeRecordTest4(input: unknown): RecordTest4 {
	return decodeRecordTest4At(input, "$");
}

function encodeTimeTest0At(value: TimeTest0, path: string): JsonValue {
	return encodeTime("none", value, path);}

function decodeTimeTest0At(input: unknown, path: string): TimeTest0 {
	return decodeTime("none", input, path) as TimeTest0;}

export function encodeTimeTest0(value: TimeTest0): JsonValue {
	return encodeTimeTest0At(value, "$");
}

export function decodeTimeTest0(input: unknown): TimeTest0 {
	return decodeTimeTest0At(input, "$");
}

function encodeTimeTest1At(value: TimeTest1, path: string): JsonValue {
	return encodeTime("none", value, path);}

function decodeTimeTest1At(input: unknown, path: string): TimeTest1 {
	return decodeTime("none", input, path) as TimeTest1;}

export function encodeTimeTest1(value: TimeTest1): JsonValue {
	return encodeTimeTest1At(value, "$");
}

export function decodeTimeTest1(input: unknown): TimeTest1 {
	return decodeTimeTest1At(input, "$");
}

function encodeTimeTest2At(value: TimeTest2, path: string): JsonValue {
	return encodeTime("date", value, path);}

function decodeTimeTest2At(input: unknown, path: string): TimeTest2 {
	return decodeTime("date", input, path) as TimeTest2;}

export function encodeTimeTest2(value: TimeTest2): JsonValue {
	return encodeTimeTest2At(value, "$");
}

export function decodeTimeTest2(input: unknown): TimeTest2 {
	return decodeTimeTest2At(input, "$");
}

function encodeTimeTest3At(value: TimeTest3, path: string): JsonValue {
	return encodeTime("time", value, path);}

function decodeTimeTest3At(input: unknown, path: string): TimeTest3 {
	return decodeTime("time", input, path) as TimeTest3;}

export function encodeTimeTest3(value: TimeTest3): JsonValue {
	return encodeTimeTest3At(value, "$");
}

export function decodeTimeTest3(input: unknown): TimeTest3 {
	return decodeTimeTest3At(input, "$");
}

function encodeTimeTest4At(value: TimeTest4, path: string): JsonValue {
	return encodeTime("duration", value, path);}

function decodeTimeTest4At(input: unknown, path: string): TimeTest4 {
	return decodeTime("duration", input, path) as TimeTest4;}

export function encodeTimeTest4(value: TimeTest4): JsonValue {
	return encodeTimeTest4At(value, "$");
}

export function decodeTimeTest4(input: unknown): TimeTest4 {
	return decodeTimeTest4At(input, "$");
}

function encodeAnyTest0At(value: AnyTest0, path: string): JsonValue {
	return encodeAny(value, path);}

function decodeAnyTest0At(input: unknown, path: string): AnyTest0 {
	return decodeAny(input, path) as AnyTest0;}

export function encodeAnyTest0(value: AnyTest0): JsonValue {
	return encodeAnyTest0At(value, "$");
}

export function decodeAnyTest0(input: unknown): AnyTest0 {
	return decodeAnyTest0At(input, "$");
}

function encodeAnyTest1At(value: AnyTest1, path: string): JsonValue {
	return encodeAny(value, path);}

function decodeAnyTest1At(input: unknown, path: string): AnyTest1 {
	return decodeAny(input, path) as AnyTest1;}

export function encodeAnyTest1(value: AnyTest1): JsonValue {
	return encodeAnyTest1At(value, "$");
}

export function decodeAnyTest1(input: unknown): AnyTest1 {
	return decodeAnyTest1At(input, "$");
}

function encodeAnyTest2At(value: AnyTest2, path: string): JsonValue {
	return encodeAny(value, path);}

function decodeAnyTest2At(input: unknown, path: string): AnyTest2 {
	return decodeAny(input, path) as AnyTest2;}

export function encodeAnyTest2(value: AnyTest2): JsonValue {
	return encodeAnyTest2At(value, "$");
}

export function decodeAnyTest2(input: unknown): AnyTest2 {
	return decodeAnyTest2At(input, "$");
}

function encodeAnyTest3At(value: AnyTest3, path: string): JsonValue {
	return encodeAny(value, path);}

function decodeAnyTest3At(input: unknown, path: string): AnyTest3 {
	return decodeAny(input, path) as AnyTest3;}

export function encodeAnyTest3(value: AnyTest3): JsonValue {
	return encodeAnyTest3At(value, "$");
}

export function decodeAnyTest3(input: unknown): AnyTest3 {
	return decodeAnyTest3At(input, "$");
}

function encodePersonAt(value: Person, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["age"] = encodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = encodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	return result;
}

function decodePersonAt(input: unknown, path: string): Person {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["age"] = decodeNumber("natural", object["age"], pathField(path, "age"));
	result["deceased"] = decodeBoolean(object["deceased"], pathField(path, "deceased"));
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	return result as Person;
}

export function encodePerson(value: Person): JsonValue {
	return encodePersonAt(value, "$");
}

export function decodePerson(input: unknown): Person {
	return decodePersonAt(input, "$");
}

function encodePeopleAt(value: People, path: string): JsonValue {
	return ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = encodePersonAt(entries[index] as Person, pathIndex(path, index));
		}
		return result;
	})(value, path);}

function decodePeopleAt(input: unknown, path: string): People {
	return ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = decodePersonAt(entries[index], pathIndex(path, index));
		}
		return result;
	})(input, path) as People;}

export function encodePeople(value: People): JsonValue {
	return encodePeopleAt(value, "$");
}

export function decodePeople(input: unknown): People {
	return decodePeopleAt(input, "$");
}

function encodeOneOfTest0At(value: OneOfTest0, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest0At(input: unknown, path: string): OneOfTest0 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest0;}

export function encodeOneOfTest0(value: OneOfTest0): JsonValue {
	return encodeOneOfTest0At(value, "$");
}

export function decodeOneOfTest0(input: unknown): OneOfTest0 {
	return decodeOneOfTest0At(input, "$");
}

function encodeOneOfTest1At(value: OneOfTest1, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest1At(input: unknown, path: string): OneOfTest1 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest1;}

export function encodeOneOfTest1(value: OneOfTest1): JsonValue {
	return encodeOneOfTest1At(value, "$");
}

export function decodeOneOfTest1(input: unknown): OneOfTest1 {
	return decodeOneOfTest1At(input, "$");
}

function encodeOneOfTest2Option2At(value: OneOfTest2Option2, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["bar"] = encodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOneOfTest2Option2At(input: unknown, path: string): OneOfTest2Option2 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["bar"] = decodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OneOfTest2Option2;
}

export function encodeOneOfTest2Option2(value: OneOfTest2Option2): JsonValue {
	return encodeOneOfTest2Option2At(value, "$");
}

export function decodeOneOfTest2Option2(input: unknown): OneOfTest2Option2 {
	return decodeOneOfTest2Option2At(input, "$");
}

function encodeOneOfTest2At(value: OneOfTest2, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeOneOfTest2Option2At(value as OneOfTest2Option2, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest2At(input: unknown, path: string): OneOfTest2 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeText("none", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeNumber("natural", value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeOneOfTest2Option2At(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest2;}

export function encodeOneOfTest2(value: OneOfTest2): JsonValue {
	return encodeOneOfTest2At(value, "$");
}

export function decodeOneOfTest2(input: unknown): OneOfTest2 {
	return decodeOneOfTest2At(input, "$");
}

function encodeOneOfTest3At(value: OneOfTest3, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeFooAt(value as Foo, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeBarAt(value as Bar, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest3At(input: unknown, path: string): OneOfTest3 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeFooAt(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeBarAt(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest3;}

export function encodeOneOfTest3(value: OneOfTest3): JsonValue {
	return encodeOneOfTest3At(value, "$");
}

export function decodeOneOfTest3(input: unknown): OneOfTest3 {
	return decodeOneOfTest3At(input, "$");
}

function encodeOneOfTest4Option0At(value: OneOfTest4Option0, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["bar"] = encodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOneOfTest4Option0At(input: unknown, path: string): OneOfTest4Option0 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["bar"] = decodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OneOfTest4Option0;
}

export function encodeOneOfTest4Option0(value: OneOfTest4Option0): JsonValue {
	return encodeOneOfTest4Option0At(value, "$");
}

export function decodeOneOfTest4Option0(input: unknown): OneOfTest4Option0 {
	return decodeOneOfTest4Option0At(input, "$");
}

function encodeOneOfTest4Option1At(value: OneOfTest4Option1, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOneOfTest4Option1At(input: unknown, path: string): OneOfTest4Option1 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OneOfTest4Option1;
}

export function encodeOneOfTest4Option1(value: OneOfTest4Option1): JsonValue {
	return encodeOneOfTest4Option1At(value, "$");
}

export function decodeOneOfTest4Option1(input: unknown): OneOfTest4Option1 {
	return decodeOneOfTest4Option1At(input, "$");
}

function encodeOneOfTest4At(value: OneOfTest4, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeOneOfTest4Option0At(value as OneOfTest4Option0, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeOneOfTest4Option1At(value as OneOfTest4Option1, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest4At(input: unknown, path: string): OneOfTest4 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeOneOfTest4Option0At(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeOneOfTest4Option1At(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest4;}

export function encodeOneOfTest4(value: OneOfTest4): JsonValue {
	return encodeOneOfTest4At(value, "$");
}

export function decodeOneOfTest4(input: unknown): OneOfTest4 {
	return decodeOneOfTest4At(input, "$");
}

function encodeOneOfTest5Option0At(value: OneOfTest5Option0, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOneOfTest5Option0At(input: unknown, path: string): OneOfTest5Option0 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OneOfTest5Option0;
}

export function encodeOneOfTest5Option0(value: OneOfTest5Option0): JsonValue {
	return encodeOneOfTest5Option0At(value, "$");
}

export function decodeOneOfTest5Option0(input: unknown): OneOfTest5Option0 {
	return decodeOneOfTest5Option0At(input, "$");
}

function encodeOneOfTest5Option1At(value: OneOfTest5Option1, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["bar"] = encodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = encodeText("none", object["foo"], pathField(path, "foo"));
	return result;
}

function decodeOneOfTest5Option1At(input: unknown, path: string): OneOfTest5Option1 {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["bar"] = decodeNumber("none", object["bar"], pathField(path, "bar"));
	result["foo"] = decodeText("none", object["foo"], pathField(path, "foo"));
	return result as OneOfTest5Option1;
}

export function encodeOneOfTest5Option1(value: OneOfTest5Option1): JsonValue {
	return encodeOneOfTest5Option1At(value, "$");
}

export function decodeOneOfTest5Option1(input: unknown): OneOfTest5Option1 {
	return decodeOneOfTest5Option1At(input, "$");
}

function encodeOneOfTest5At(value: OneOfTest5, path: string): JsonValue {
	return ((value: unknown, path: string): JsonValue => {
		try {
			return encodeOneOfTest5Option0At(value as OneOfTest5Option0, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return encodeOneOfTest5Option1At(value as OneOfTest5Option1, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("encode", path, "no OneOf option matched");
	})(value, path);}

function decodeOneOfTest5At(input: unknown, path: string): OneOfTest5 {
	return ((value: unknown, path: string): unknown => {
		try {
			return decodeOneOfTest5Option0At(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		try {
			return decodeOneOfTest5Option1At(value, path);
		} catch (error) {
			if (!(error instanceof CodecError)) throw error;
		}
		return fail("decode", path, "no OneOf option matched");
	})(input, path) as OneOfTest5;}

export function encodeOneOfTest5(value: OneOfTest5): JsonValue {
	return encodeOneOfTest5At(value, "$");
}

export function decodeOneOfTest5(input: unknown): OneOfTest5 {
	return decodeOneOfTest5At(input, "$");
}

function encodeFooAt(value: Foo, path: string): JsonValue {
	return encodeText("none", value, path);}

function decodeFooAt(input: unknown, path: string): Foo {
	return decodeText("none", input, path) as Foo;}

export function encodeFoo(value: Foo): JsonValue {
	return encodeFooAt(value, "$");
}

export function decodeFoo(input: unknown): Foo {
	return decodeFooAt(input, "$");
}

function encodeBarAt(value: Bar, path: string): JsonValue {
	return encodeNumber("natural", value, path);}

function decodeBarAt(input: unknown, path: string): Bar {
	return decodeNumber("natural", input, path) as Bar;}

export function encodeBar(value: Bar): JsonValue {
	return encodeBarAt(value, "$");
}

export function decodeBar(input: unknown): Bar {
	return decodeBarAt(input, "$");
}