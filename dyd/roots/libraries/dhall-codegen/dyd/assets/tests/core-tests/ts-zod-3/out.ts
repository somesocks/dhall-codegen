

import { z } from 'zod';



	/** any test 0 */
export const AnyTest0 =
	z.unknown();
export type TAnyTest0 = z.infer<typeof AnyTest0>


	/** any test 1 */
export const AnyTest1 =
	z.any();
export type TAnyTest1 = z.infer<typeof AnyTest1>


	/** any test 2 */
export const AnyTest2 =
	z.unknown().describe("comment");
export type TAnyTest2 = z.infer<typeof AnyTest2>


	/** any test 3 */
export const AnyTest3 =
	z.unknown().describe("multi-line comment");
export type TAnyTest3 = z.infer<typeof AnyTest3>


	/** boolean test 0 */
export const BooleanTest0 =
	z.boolean();
export type TBooleanTest0 = z.infer<typeof BooleanTest0>


	/** boolean test 1 */
export const BooleanTest1 =
	z.boolean().describe("comment");
export type TBooleanTest1 = z.infer<typeof BooleanTest1>


	/** boolean test 2 */
export const BooleanTest2 =
	z.boolean().describe("multi-line comment");
export type TBooleanTest2 = z.infer<typeof BooleanTest2>


	/** number test 0 */
export const NumberTest0 =
	z.number();
export type TNumberTest0 = z.infer<typeof NumberTest0>


	/** number test 1 */
export const NumberTest1 =
	z.number().describe("number");
export type TNumberTest1 = z.infer<typeof NumberTest1>


	/** number test 2 */
export const NumberTest2 =
	z.number().int().nonnegative().describe("natural");
export type TNumberTest2 = z.infer<typeof NumberTest2>


	/** number test 3 */
export const NumberTest3 =
	z.number().int().describe("integer");
export type TNumberTest3 = z.infer<typeof NumberTest3>


	/** number test 4 */
export const NumberTest4 =
	z.number().describe("decimal");
export type TNumberTest4 = z.infer<typeof NumberTest4>


	/** text test 0 */
export const TextTest0 =
	z.string();
export type TTextTest0 = z.infer<typeof TextTest0>


	/** text test 1 */
export const TextTest1 =
	z.string().describe("text");
export type TTextTest1 = z.infer<typeof TextTest1>


	/** text test 2 */
export const TextTest2 =
	z.email().describe("email");
export type TTextTest2 = z.infer<typeof TextTest2>


	/** text test 3 */
export const TextTest3 =
	z.url().describe("url");
export type TTextTest3 = z.infer<typeof TextTest3>


	/** text test 4 */
export const TextTest4 =
	z.literal("foo").describe("text literal");
export type TTextTest4 = z.infer<typeof TextTest4>


	/** time test 0 */
export const TimeTest0 =
	z.date();
export type TTimeTest0 = z.infer<typeof TimeTest0>


	/** time test 1 */
export const TimeTest1 =
	z.date().describe("comment");
export type TTimeTest1 = z.infer<typeof TimeTest1>


export const Person =
	z.object({
		age :
			z.number().int().nonnegative(),
		deceased :
			z.boolean(),
		name :
			z.string(),
	});
export type TPerson = z.infer<typeof Person>


export const People =
	z.array(
		Person
	);
export type TPeople = z.infer<typeof People>


	/** optional test 0 */
export const OptionalTest0 =
	z.string().optional();
export type TOptionalTest0 = z.infer<typeof OptionalTest0>


export const OptionalTest1Value =
	z.object({
		foo :
			z.string(),
	});
export type TOptionalTest1Value = z.infer<typeof OptionalTest1Value>


	/** optional test 1 */
export const OptionalTest1 =
	OptionalTest1Value.optional();
export type TOptionalTest1 = z.infer<typeof OptionalTest1>


	/** optional test 2 */
export const OptionalTest2 =
	z.string().optional();
export type TOptionalTest2 = z.infer<typeof OptionalTest2>


	/** list test 0 */
export const ListTest0 =
	z.array(
		z.string()
	).describe("a list");
export type TListTest0 = z.infer<typeof ListTest0>


	/** list test 1 */
export const ListTest1 =
	z.array(
		z.array(
			z.string()
		).describe("a list inside a list")
	).describe("a list");
export type TListTest1 = z.infer<typeof ListTest1>


export const ListTest2Values =
	z.object({
		foo :
			z.string(),
	}).describe("a record inside a list");
export type TListTest2Values = z.infer<typeof ListTest2Values>


	/** list test 2 */
export const ListTest2 =
	z.array(
		ListTest2Values
	).describe("a list");
export type TListTest2 = z.infer<typeof ListTest2>


	/** set test 0 */
export const SetTest0 =
	z.set(
		z.string()
	).describe("a set");
export type TSetTest0 = z.infer<typeof SetTest0>


	/** set test 1 */
export const SetTest1 =
	z.array(
		z.string()
	).describe("a set-like list");
export type TSetTest1 = z.infer<typeof SetTest1>


	/** set test 2 */
export const SetTest2 =
	z.set(
		z.set(
			z.string()
		).describe("a set inside a set")
	).describe("a set");
export type TSetTest2 = z.infer<typeof SetTest2>


export const SetTest3Values =
	z.object({
		foo :
			z.string(),
	}).describe("a record inside a set");
export type TSetTest3Values = z.infer<typeof SetTest3Values>


	/** set test 3 */
export const SetTest3 =
	z.set(
		SetTest3Values
	).describe("a set");
export type TSetTest3 = z.infer<typeof SetTest3>


	/** map test 0 */
export const MapTest0 =
	z.map(
		z.string(),
		z.string()
	).describe("a map");
export type TMapTest0 = z.infer<typeof MapTest0>


	/** map test 1 */
export const MapTest1 =
	z.record(
		z.string(),
		z.string()
	).describe("a map-like record");
export type TMapTest1 = z.infer<typeof MapTest1>


	/** map test 2 */
export const MapTest2 =
	z.map(
		z.string(),
		z.map(
			z.string(),
			z.string()
		).describe("a map inside a map")
	).describe("a map");
export type TMapTest2 = z.infer<typeof MapTest2>


export const MapTest3Keys =
	z.object({
		foo :
			z.string(),
	}).describe("a keys record inside a map");
export type TMapTest3Keys = z.infer<typeof MapTest3Keys>


export const MapTest3Values =
	z.object({
		foo :
			z.string(),
	}).describe("a values record inside a map");
export type TMapTest3Values = z.infer<typeof MapTest3Values>


	/** map test 3 */
export const MapTest3 =
	z.map(
		MapTest3Keys,
		MapTest3Values
	).describe("a map");
export type TMapTest3 = z.infer<typeof MapTest3>


	/** oneOf test 0 */
export const OneOfTest0 =
	z.union([
		z.string(),
		z.number().int().nonnegative()
	]);
export type TOneOfTest0 = z.infer<typeof OneOfTest0>


	/** oneOf test 1 */
export const OneOfTest1 =
	z.union([
		z.string(),
		z.number().int().nonnegative()
	]).describe("number or string");
export type TOneOfTest1 = z.infer<typeof OneOfTest1>


export const OneOfTest2Option2 =
	z.object({
		bar :
			z.number(),
		foo :
			z.string(),
	});
export type TOneOfTest2Option2 = z.infer<typeof OneOfTest2Option2>


	/** oneOf test 2 */
export const OneOfTest2 =
	z.union([
		z.string(),
		z.number().int().nonnegative(),
		OneOfTest2Option2
	]).describe("number or string or record");
export type TOneOfTest2 = z.infer<typeof OneOfTest2>


	/** oneOf test 3 */
export const OneOfTest3 =
	z.union([
		Foo,
		Bar
	]).describe("named references");
export type TOneOfTest3 = z.infer<typeof OneOfTest3>


export const AllOfTest0Option0 =
	z.object({
		bar :
			z.number(),
	});
export type TAllOfTest0Option0 = z.infer<typeof AllOfTest0Option0>


export const AllOfTest0Option1 =
	z.object({
		foo :
			z.string(),
	});
export type TAllOfTest0Option1 = z.infer<typeof AllOfTest0Option1>


	/** allOf test 0 */
export const AllOfTest0 =
	z.intersection(
		AllOfTest0Option0,
		AllOfTest0Option1
	).describe("all of two records");
export type TAllOfTest0 = z.infer<typeof AllOfTest0>


	/** tuple test 0 */
export const TupleTest0 =
	z.tuple([
		z.string(),
		z.number().int().nonnegative()
	]);
export type TTupleTest0 = z.infer<typeof TupleTest0>


	/** tuple test 1 */
export const TupleTest1 =
	z.tuple([
		z.string(),
		z.number().int().nonnegative()
	]).describe("a tuple");
export type TTupleTest1 = z.infer<typeof TupleTest1>


	/** tuple test 2 */
export const TupleTest2 =
	z.tuple([
		z.string(),
		z.tuple([
			z.string(),
			z.number().int().nonnegative()
		]).describe("a tuple in a tuple")
	]).describe("a tuple");
export type TTupleTest2 = z.infer<typeof TupleTest2>


	/** record test 0 */
export const RecordTest0 =
	z.object({
		age :
			z.number().int().nonnegative(),
		deceased :
			z.boolean(),
		name :
			z.string(),
	});
export type TRecordTest0 = z.infer<typeof RecordTest0>


	/** record test 1 */
export const RecordTest1 =
	z.object({
		age :
			z.number().int().nonnegative(),
		deceased :
			z.boolean(),
		name :
			z.string(),
	}).describe("a record");
export type TRecordTest1 = z.infer<typeof RecordTest1>


export const RecordTest2Contact =
	z.object({
		email :
			z.string().optional(),
		phone :
			z.string().optional(),
	});
export type TRecordTest2Contact = z.infer<typeof RecordTest2Contact>


	/** record test 2 */
export const RecordTest2 =
	z.object({
		age :
			z.number().int().nonnegative(),
		contact :
			RecordTest2Contact,
		deceased :
			z.boolean(),
		name :
			z.string(),
	}).describe("a record with an embedded record");
export type TRecordTest2 = z.infer<typeof RecordTest2>


	/** record test 3 */
export const RecordTest3 =
	z.object({
		name :
			z.string(),
		age :
			z.number().int().nonnegative().optional(),
		deceased :
			z.boolean().optional(),
	}).describe("a record with optional props");
export type TRecordTest3 = z.infer<typeof RecordTest3>


	/** record test 4 */
export const RecordTest4 =
	z.object({
		id :
			z.string(),
		status :
			z.string(),
		age :
			z.number().int().nonnegative().optional(),
	});
export type TRecordTest4 = z.infer<typeof RecordTest4>


	/** function test 0 */
export const FunctionTest0 =
	z.function()
		.args(
		)
		.returns(
			z.void()
		);
export type TFunctionTest0 = z.infer<typeof FunctionTest0>


	/** function test 1 */
export const FunctionTest1 =
	z.function()
		.args(
		)
		.returns(
			z.promise(z.void())
		);
export type TFunctionTest1 = z.infer<typeof FunctionTest1>


	/** function test 2 */
export const FunctionTest2 =
	z.function()
		.args(
			z.boolean()
		)
		.returns(
			z.void()
		);
export type TFunctionTest2 = z.infer<typeof FunctionTest2>


	/** function test 3 */
export const FunctionTest3 =
	z.function()
		.args(
			z.boolean()
		)
		.returns(
			z.promise(z.void())
		);
export type TFunctionTest3 = z.infer<typeof FunctionTest3>


	/** function test 4 */
export const FunctionTest4 =
	z.function()
		.args(
			z.boolean(),
			z.number(),
			z.string()
		)
		.returns(
			z.void()
		);
export type TFunctionTest4 = z.infer<typeof FunctionTest4>


	/** function test 5 */
export const FunctionTest5 =
	z.function()
		.args(
			z.boolean(),
			z.number(),
			z.string()
		)
		.returns(
			z.promise(z.void())
		);
export type TFunctionTest5 = z.infer<typeof FunctionTest5>


	/** function test 6 */
export const FunctionTest6 =
	z.function()
		.args(
		)
		.returns(
			z.void()
		);
export type TFunctionTest6 = z.infer<typeof FunctionTest6>


	/** function test 7 */
export const FunctionTest7 =
	z.function()
		.args(
		)
		.returns(
			z.promise(z.void())
		);
export type TFunctionTest7 = z.infer<typeof FunctionTest7>


	/** function test 8 */
export const FunctionTest8 =
	z.function()
		.args(
		)
		.returns(
			z.boolean()
		);
export type TFunctionTest8 = z.infer<typeof FunctionTest8>


	/** function test 9 */
export const FunctionTest9 =
	z.function()
		.args(
		)
		.returns(
			z.promise(
				z.boolean()
			)
		);
export type TFunctionTest9 = z.infer<typeof FunctionTest9>


	/** function test 10 */
export const FunctionTest10 =
	z.function()
		.args(
		)
		.returns(
			z.tuple([
				z.boolean(),
				z.number(),
				z.string()
			])
		);
export type TFunctionTest10 = z.infer<typeof FunctionTest10>


	/** function test 11 */
export const FunctionTest11 =
	z.function()
		.args(
		)
		.returns(
			z.promise(z.tuple([
				z.boolean(),
				z.number(),
				z.string()
			]))
		);
export type TFunctionTest11 = z.infer<typeof FunctionTest11>


	/** function test 12 */
export const FunctionTest12 =
	z.function()
		.args(
			z.number().int().nonnegative(),
			z.string()
		)
		.returns(
			z.tuple([
				z.string(),
				z.boolean()
			])
		);
export type TFunctionTest12 = z.infer<typeof FunctionTest12>


	/** function test 13 */
export const FunctionTest13 =
	z.function()
		.args(
			z.number().int().nonnegative(),
			z.string()
		)
		.returns(
			z.promise(z.tuple([
				z.string(),
				z.boolean()
			]))
		);
export type TFunctionTest13 = z.infer<typeof FunctionTest13>


export const FunctionTest14Input =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest14Input = z.infer<typeof FunctionTest14Input>


export const FunctionTest14Output =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest14Output = z.infer<typeof FunctionTest14Output>


	/** function test 14 */
export const FunctionTest14 =
	z.function()
		.args(
			FunctionTest14Input
		)
		.returns(
			z.promise(
				FunctionTest14Output
			)
		);
export type TFunctionTest14 = z.infer<typeof FunctionTest14>


export const FunctionTest15Input0 =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest15Input0 = z.infer<typeof FunctionTest15Input0>


export const FunctionTest15Input1 =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest15Input1 = z.infer<typeof FunctionTest15Input1>


export const FunctionTest15Output0 =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest15Output0 = z.infer<typeof FunctionTest15Output0>


export const FunctionTest15Output1 =
	z.object({
		bar :
			z.string(),
		foo :
			z.number().int().nonnegative(),
	});
export type TFunctionTest15Output1 = z.infer<typeof FunctionTest15Output1>


	/** function test 15 */
export const FunctionTest15 =
	z.function()
		.args(
			FunctionTest15Input0,
			FunctionTest15Input1
		)
		.returns(
			z.promise(z.tuple([
				FunctionTest15Output0,
				FunctionTest15Output1
			]))
		);
export type TFunctionTest15 = z.infer<typeof FunctionTest15>
