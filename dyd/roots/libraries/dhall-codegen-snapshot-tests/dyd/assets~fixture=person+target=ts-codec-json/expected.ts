export type PersonContact =
	/** contact details */
	{
		phone_number :
			/** E.164 telephone number */
			string;
		email ?:
			/** contact email */
			string;
	};

export type Person =
	{
		appointment_time :
			/** ISO 8601 local time */
			string;
		binary_data :
			/** RFC 4648 Base64 */
			string;
		birth_date :
			/** ISO 8601 calendar date */
			string;
		contact :
			/** contact details */
			PersonContact;
		created_at :
			/** RFC 3339 date-time */
			string;
		date_of_birth :
			/** date of birth */
			Date;
		destination_ip :
			/** IPv6 address */
			string;
		friends :
			/** friends */
			Array<
				Person
			>;
		id :
			/** RFC 4122 UUID */
			string;
		name :
			/** full name */
			string;
		retention_period :
			/** ISO 8601 duration */
			string;
		source_ip :
			/** IPv4 address */
			string;
		token :
			/** RFC 4648 Base64url */
			string;
	};

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



function encodePersonContactAt(value: PersonContact, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["phone_number"] = encodeText("e164", object["phone_number"], pathField(path, "phone_number"));
	if (hasOwn(object, "email") && object["email"] !== undefined) result["email"] = encodeText("email", object["email"], pathField(path, "email"));
	return result;
}

function decodePersonContactAt(input: unknown, path: string): PersonContact {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["phone_number"] = decodeText("e164", object["phone_number"], pathField(path, "phone_number"));
	if (hasOwn(object, "email") && object["email"] !== null) result["email"] = decodeText("email", object["email"], pathField(path, "email"));
	return result as PersonContact;
}

export function encodePersonContact(value: PersonContact): JsonValue {
	return encodePersonContactAt(value, "$");
}

export function decodePersonContact(input: unknown): PersonContact {
	return decodePersonContactAt(input, "$");
}

function encodePersonAt(value: Person, path: string): JsonValue {
	const object = asObject("encode", value, path);
	const result: { [key: string]: JsonValue } = {};
	result["appointment_time"] = encodeTime("time", object["appointment_time"], pathField(path, "appointment_time"));
	result["binary_data"] = encodeText("base64", object["binary_data"], pathField(path, "binary_data"));
	result["birth_date"] = encodeText("isoDate", object["birth_date"], pathField(path, "birth_date"));
	result["contact"] = encodePersonContactAt(object["contact"] as PersonContact, pathField(path, "contact"));
	result["created_at"] = encodeText("isoDateTime", object["created_at"], pathField(path, "created_at"));
	result["date_of_birth"] = encodeTime("date", object["date_of_birth"], pathField(path, "date_of_birth"));
	result["destination_ip"] = encodeText("ipv6", object["destination_ip"], pathField(path, "destination_ip"));
	result["friends"] = ((input: unknown, path: string): JsonValue[] => {
		const entries = asArray("encode", input, path);
		const result: JsonValue[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = encodePersonAt(entries[index] as Person, pathIndex(path, index));
		}
		return result;
	})(object["friends"], pathField(path, "friends"));
	result["id"] = encodeText("uuid", object["id"], pathField(path, "id"));
	result["name"] = encodeText("none", object["name"], pathField(path, "name"));
	result["retention_period"] = encodeTime("duration", object["retention_period"], pathField(path, "retention_period"));
	result["source_ip"] = encodeText("ipv4", object["source_ip"], pathField(path, "source_ip"));
	result["token"] = encodeText("base64url", object["token"], pathField(path, "token"));
	return result;
}

function decodePersonAt(input: unknown, path: string): Person {
	const object = asObject("decode", input, path);
	const result: { [key: string]: unknown } = {};
	result["appointment_time"] = decodeTime("time", object["appointment_time"], pathField(path, "appointment_time"));
	result["binary_data"] = decodeText("base64", object["binary_data"], pathField(path, "binary_data"));
	result["birth_date"] = decodeText("isoDate", object["birth_date"], pathField(path, "birth_date"));
	result["contact"] = decodePersonContactAt(object["contact"], pathField(path, "contact"));
	result["created_at"] = decodeText("isoDateTime", object["created_at"], pathField(path, "created_at"));
	result["date_of_birth"] = decodeTime("date", object["date_of_birth"], pathField(path, "date_of_birth"));
	result["destination_ip"] = decodeText("ipv6", object["destination_ip"], pathField(path, "destination_ip"));
	result["friends"] = ((input: unknown, path: string): unknown[] => {
		const entries = asArray("decode", input, path);
		const result: unknown[] = new Array(entries.length);
		for (let index = 0; index < entries.length; index += 1) {
			result[index] = decodePersonAt(entries[index], pathIndex(path, index));
		}
		return result;
	})(object["friends"], pathField(path, "friends"));
	result["id"] = decodeText("uuid", object["id"], pathField(path, "id"));
	result["name"] = decodeText("none", object["name"], pathField(path, "name"));
	result["retention_period"] = decodeTime("duration", object["retention_period"], pathField(path, "retention_period"));
	result["source_ip"] = decodeText("ipv4", object["source_ip"], pathField(path, "source_ip"));
	result["token"] = decodeText("base64url", object["token"], pathField(path, "token"));
	return result as Person;
}

export function encodePerson(value: Person): JsonValue {
	return encodePersonAt(value, "$");
}

export function decodePerson(input: unknown): Person {
	return decodePersonAt(input, "$");
}