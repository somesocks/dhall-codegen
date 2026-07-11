


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


/** time test 0 */
export type TimeTest0 =
	Date;


/** time test 1 */
export type TimeTest1 =
	/** comment */
	Date;


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


export type AllOfTest0Option0 =
	{
		bar :
			number;
	};


export type AllOfTest0Option1 =
	{
		foo :
			string;
	};


/** allOf test 0 */
export type AllOfTest0 =
	/** all of two records */
	(
		AllOfTest0Option0 &
		AllOfTest0Option1
	);


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


/** function test 0 */
export type FunctionTest0 =
	(
	) => 
	void;


/** function test 1 */
export type FunctionTest1 =
	(
	) => 
	Promise<void>;


/** function test 2 */
export type FunctionTest2 =
	(
		x0 :
			boolean
	) => 
	void;


/** function test 3 */
export type FunctionTest3 =
	(
		x0 :
			boolean
	) => 
	Promise<void>;


/** function test 4 */
export type FunctionTest4 =
	(
		x0 :
			boolean,
		x1 :
			number,
		x2 :
			string
	) => 
	void;


/** function test 5 */
export type FunctionTest5 =
	(
		x0 :
			boolean,
		x1 :
			number,
		x2 :
			string
	) => 
	Promise<void>;


/** function test 6 */
export type FunctionTest6 =
	(
	) => 
	void;


/** function test 7 */
export type FunctionTest7 =
	(
	) => 
	Promise<void>;


/** function test 8 */
export type FunctionTest8 =
	(
	) => 
	boolean;


/** function test 9 */
export type FunctionTest9 =
	(
	) => 
	Promise<
		boolean
	>;


/** function test 10 */
export type FunctionTest10 =
	(
	) => 
	[
		boolean,
		number,
		string
	];


/** function test 11 */
export type FunctionTest11 =
	(
	) => 
	Promise<[
		boolean,
		number,
		string
	]>;


/** function test 12 */
export type FunctionTest12 =
	(
		x0 :
			number,
		x1 :
			string
	) => 
	[
		string,
		boolean
	];


/** function test 13 */
export type FunctionTest13 =
	(
		x0 :
			number,
		x1 :
			string
	) => 
	Promise<[
		string,
		boolean
	]>;


export type FunctionTest14Input =
	{
		bar :
			string;
		foo :
			number;
	};


export type FunctionTest14Output =
	{
		bar :
			string;
		foo :
			number;
	};


/** function test 14 */
export type FunctionTest14 =
	(
		x0 :
			FunctionTest14Input
	) => 
	Promise<
		FunctionTest14Output
	>;


export type FunctionTest15Input0 =
	{
		bar :
			string;
		foo :
			number;
	};


export type FunctionTest15Input1 =
	{
		bar :
			string;
		foo :
			number;
	};


export type FunctionTest15Output0 =
	{
		bar :
			string;
		foo :
			number;
	};


export type FunctionTest15Output1 =
	{
		bar :
			string;
		foo :
			number;
	};


/** function test 15 */
export type FunctionTest15 =
	(
		x0 :
			FunctionTest15Input0,
		x1 :
			FunctionTest15Input1
	) => 
	Promise<[
		FunctionTest15Output0,
		FunctionTest15Output1
	]>;
