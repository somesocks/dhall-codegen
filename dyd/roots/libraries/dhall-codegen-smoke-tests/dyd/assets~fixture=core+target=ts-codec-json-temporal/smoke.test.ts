import { Temporal } from "@js-temporal/polyfill";
import {
  CodecError,
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

const instant = Temporal.Instant.from("2026-07-25T14:30:00.123Z");
const decodedInstant = decodeTimeTest0(encodeTimeTest0(instant));
if (Temporal.Instant.compare(decodedInstant, instant) !== 0) throw new Error("instant did not round-trip");
if (Temporal.Instant.compare(decodeTimeTest1(encodeTimeTest1(instant)), instant) !== 0) {
  throw new Error("described instant did not round-trip");
}

const calendarDate = Temporal.PlainDate.from("1815-12-10");
const decodedCalendarDate = decodeTimeTest2(encodeTimeTest2(calendarDate));
if (Temporal.PlainDate.compare(decodedCalendarDate, calendarDate) !== 0) {
  throw new Error("calendar date did not round-trip");
}

const localTime = Temporal.PlainTime.from("14:30:00.123");
if (Temporal.PlainTime.compare(decodeTimeTest3(encodeTimeTest3(localTime)), localTime) !== 0) {
  throw new Error("local time did not round-trip");
}

const duration = Temporal.Duration.from("P1Y2M3DT4H5M6S");
if (Temporal.Duration.compare(decodeTimeTest4(encodeTimeTest4(duration)), duration) !== 0) {
  throw new Error("duration did not round-trip");
}

expectCodecError(() => decodeTimeTest0("not-an-instant"));
expectCodecError(() => decodeTimeTest2("not-a-date"));
expectCodecError(() => decodeTimeTest3("not-a-time"));
expectCodecError(() => decodeTimeTest4("not-a-duration"));
