import { Temporal } from "@js-temporal/polyfill";

/** time test 0 */
export type TimeTest0 =
	Temporal.Instant;


/** time test 1 */
export type TimeTest1 =
	/** comment */
	Temporal.Instant;


/** time test 2 */
export type TimeTest2 =
	/** calendar date */
	Temporal.PlainDate;


/** time test 3 */
export type TimeTest3 =
	/** local time */
	Temporal.PlainTime;


/** time test 4 */
export type TimeTest4 =
	/** ISO 8601 duration */
	Temporal.Duration;

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
  const temporalValue = value as { toString?: () => string };
  if (temporalValue === null || typeof temporalValue?.toString !== "function") return fail("encode", path, "expected Temporal value");
  const textVariant = variant === "none" ? "isoDateTime" : variant === "date" ? "isoDate" : variant === "time" ? "isoTime" : "isoDuration";
  return validateText(textVariant, temporalValue.toString(), "encode", path);
};

const decodeTime = (variant: string, value: unknown, path: string): unknown => {
  const text = asString("decode", value, path);
  const textVariant = variant === "none" ? "isoDateTime" : variant === "date" ? "isoDate" : variant === "time" ? "isoTime" : "isoDuration";
  validateText(textVariant, text, "decode", path);

  if (variant === "none") return Temporal.Instant.from(text);
  if (variant === "date") return Temporal.PlainDate.from(text);
  if (variant === "time") return Temporal.PlainTime.from(text);
  return Temporal.Duration.from(text);
};



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