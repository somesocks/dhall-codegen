
/** any test 0 */
export type TAnyTest0 =
	unknown;


/** any test 1 */
export type TAnyTest1 =
	any;


/** any test 2 */
export type TAnyTest2 =
	/** comment */
	unknown;


/** any test 3 */
export type TAnyTest3 =
	/** multi-line
	comment */
	unknown;


/** boolean test 0 */
export type TBooleanTest0 =
	boolean;


/** boolean test 1 */
export type TBooleanTest1 =
	/** comment */
	boolean;


/** boolean test 2 */
export type TBooleanTest2 =
	/** multi-line
	comment */
	boolean;


/** number test 0 */
export type TNumberTest0 =
	number;


/** number test 1 */
export type TNumberTest1 =
	/** number */
	number;


/** number test 2 */
export type TNumberTest2 =
	/** natural */
	number;


/** number test 3 */
export type TNumberTest3 =
	/** integer */
	number;


/** number test 4 */
export type TNumberTest4 =
	/** decimal */
	number;


/** text test 0 */
export type TTextTest0 =
	string;


/** text test 1 */
export type TTextTest1 =
	/** text */
	string;


/** text test 2 */
export type TTextTest2 =
	/** email */
	string;


/** text test 3 */
export type TTextTest3 =
	/** url */
	string;


/** text test 4 */
export type TTextTest4 =
	/** text literal */
	"foo";


/** time test 0 */
export type TTimeTest0 =
	Date;


/** time test 1 */
export type TTimeTest1 =
	/** comment */
	Date;

export type TPerson =
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};

export type TPeople =
	Array<
		/** reference to person type */
		TPerson
	>;


/** optional test 0 */
export type TOptionalTest0 =
	(
		string
		| undefined
	);

export type TOptionalTest1Value =
	{
		foo :
			string;
	};


/** optional test 1 */
export type TOptionalTest1 =
	(
		TOptionalTest1Value
		| undefined
	);


/** optional test 2 */
export type TOptionalTest2 =
	(
		string
		| undefined
	);


/** list test 0 */
export type TListTest0 =
	/** a list */
	Array<
		string
	>;


/** list test 1 */
export type TListTest1 =
	/** a list */
	Array<
		/** a list inside a list */
		Array<
			string
		>
	>;

export type TListTest2Values =
	/** a record inside a list */
	{
		foo :
			string;
	};


/** list test 2 */
export type TListTest2 =
	/** a list */
	Array<
		/** a record inside a list */
		TListTest2Values
	>;


/** set test 0 */
export type TSetTest0 =
	/** a set */
	Set<
		string
	>;


/** set test 1 */
export type TSetTest1 =
	/** a set-like list */
	Array<
		string
	>;


/** set test 2 */
export type TSetTest2 =
	/** a set */
	Set<
		/** a set inside a set */
		Set<
			string
		>
	>;

export type TSetTest3Values =
	/** a record inside a set */
	{
		foo :
			string;
	};


/** set test 3 */
export type TSetTest3 =
	/** a set */
	Set<
		/** a record inside a set */
		TSetTest3Values
	>;


/** map test 0 */
export type TMapTest0 =
	/** a map */
	Map<
		string,
		string
	>;


/** map test 1 */
export type TMapTest1 =
	/** a map-like record */
	Record<
		string,
		string
	>;


/** map test 2 */
export type TMapTest2 =
	/** a map */
	Map<
		string,
		/** a map inside a map */
		Map<
			string,
			string
		>
	>;

export type TMapTest3Keys =
	/** a keys record inside a map */
	{
		foo :
			string;
	};

export type TMapTest3Values =
	/** a values record inside a map */
	{
		foo :
			string;
	};


/** map test 3 */
export type TMapTest3 =
	/** a map */
	Map<
		/** a keys record inside a map */
		TMapTest3Keys,
		/** a values record inside a map */
		TMapTest3Values
	>;


/** oneOf test 0 */
export type TOneOfTest0 =
	(
		string |
		number
	);


/** oneOf test 1 */
export type TOneOfTest1 =
	/** number or string */
	(
		string |
		number
	);

export type TOneOfTest2Option2 =
	{
		bar :
			number;
		foo :
			string;
	};


/** oneOf test 2 */
export type TOneOfTest2 =
	/** number or string or record */
	(
		string |
		number |
		TOneOfTest2Option2
	);


/** oneOf test 3 */
export type TOneOfTest3 =
	/** named references */
	(
		TFoo |
		TBar
	);

export type TAllOfTest0Option0 =
	{
		bar :
			number;
	};

export type TAllOfTest0Option1 =
	{
		foo :
			string;
	};


/** allOf test 0 */
export type TAllOfTest0 =
	/** all of two records */
	(
		TAllOfTest0Option0 &
		TAllOfTest0Option1
	);


/** tuple test 0 */
export type TTupleTest0 =
	[
		string,
		number
	];


/** tuple test 1 */
export type TTupleTest1 =
	/** a tuple */
	[
		string,
		number
	];


/** tuple test 2 */
export type TTupleTest2 =
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
export type TRecordTest0 =
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};


/** record test 1 */
export type TRecordTest1 =
	/** a record */
	{
		age :
			number;
		deceased :
			boolean;
		name :
			string;
	};

export type TRecordTest2Contact =
	{
		email ?:
			string;
		phone ?:
			string;
	};


/** record test 2 */
export type TRecordTest2 =
	/** a record with an embedded record */
	{
		age :
			number;
		contact :
			TRecordTest2Contact;
		deceased :
			boolean;
		name :
			string;
	};


/** record test 3 */
export type TRecordTest3 =
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
export type TRecordTest4 =
	{
		id :
			string;
		status :
			string;
		age ?:
			number;
	};


/** function test 0 */
export type TFunctionTest0 =
	(
	) => 
	void;


/** function test 1 */
export type TFunctionTest1 =
	(
	) => 
	Promise<void>;


/** function test 2 */
export type TFunctionTest2 =
	(
		x0 :
			boolean
	) => 
	void;


/** function test 3 */
export type TFunctionTest3 =
	(
		x0 :
			boolean
	) => 
	Promise<void>;


/** function test 4 */
export type TFunctionTest4 =
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
export type TFunctionTest5 =
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
export type TFunctionTest6 =
	(
	) => 
	void;


/** function test 7 */
export type TFunctionTest7 =
	(
	) => 
	Promise<void>;


/** function test 8 */
export type TFunctionTest8 =
	(
	) => 
	boolean;


/** function test 9 */
export type TFunctionTest9 =
	(
	) => 
	Promise<
		boolean
	>;


/** function test 10 */
export type TFunctionTest10 =
	(
	) => 
	[
		boolean,
		number,
		string
	];


/** function test 11 */
export type TFunctionTest11 =
	(
	) => 
	Promise<[
		boolean,
		number,
		string
	]>;


/** function test 12 */
export type TFunctionTest12 =
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
export type TFunctionTest13 =
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

export type TFunctionTest14Input =
	{
		bar :
			string;
		foo :
			number;
	};

export type TFunctionTest14Output =
	{
		bar :
			string;
		foo :
			number;
	};


/** function test 14 */
export type TFunctionTest14 =
	(
		x0 :
			TFunctionTest14Input
	) => 
	Promise<
		TFunctionTest14Output
	>;

export type TFunctionTest15Input0 =
	{
		bar :
			string;
		foo :
			number;
	};

export type TFunctionTest15Input1 =
	{
		bar :
			string;
		foo :
			number;
	};

export type TFunctionTest15Output0 =
	{
		bar :
			string;
		foo :
			number;
	};

export type TFunctionTest15Output1 =
	{
		bar :
			string;
		foo :
			number;
	};


/** function test 15 */
export type TFunctionTest15 =
	(
		x0 :
			TFunctionTest15Input0,
		x1 :
			TFunctionTest15Input1
	) => 
	Promise<[
		TFunctionTest15Output0,
		TFunctionTest15Output1
	]>;