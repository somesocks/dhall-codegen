
from datetime import datetime
from pydantic import BaseModel, Field, TypeAdapter
from typing import (
    Any, Optional, Union, List, Set, Dict, Tuple, Callable, Literal
)

# backports for 3.8:
from typing_extensions import Annotated, Protocol  # for constraints/validators

try:
    from typing_extensions import TypeAlias
except Exception:
    TypeAlias = Any  # fall back; plain assignment still works

try:
    from types import NoneType          # 3.10+
except ImportError:
    NoneType = type(None)               # fallback for 3.8–3.9

# used to simulate intersection type
def _check_all_of(*adapters: TypeAdapter[Any]):
    def check(v: Any) -> Any:
        for ta in adapters:
            ta.validate_python(v)  # raises on failure
        return v
    return check



# any test 0
AnyTest0: TypeAlias = Any

# any test 1
AnyTest1: TypeAlias = Any

# any test 2
AnyTest2: TypeAlias = Any

# any test 3
AnyTest3: TypeAlias = Any

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

# time test 0
TimeTest0: TypeAlias = datetime

# time test 1
TimeTest1: TypeAlias = datetime


class Person(BaseModel):
    age : int
    deceased : bool
    name : str


People: TypeAlias = List[Person]

# optional test 0
OptionalTest0: TypeAlias = Optional[str]


class OptionalTest1Value(BaseModel):
    foo : str

# optional test 1
OptionalTest1: TypeAlias = Optional[OptionalTest1Value]

# optional test 2
OptionalTest2: TypeAlias = Optional[str]

# list test 0
ListTest0: TypeAlias = List[str]

# list test 1
ListTest1: TypeAlias = List[List[str]]


class ListTest2Values(BaseModel):# a record inside a list
    foo : str

# list test 2
ListTest2: TypeAlias = List[ListTest2Values]

# set test 0
SetTest0: TypeAlias = Set[str]

# set test 1
SetTest1: TypeAlias = List[str]

# set test 2
SetTest2: TypeAlias = Set[Set[str]]


class SetTest3Values(BaseModel):# a record inside a set
    foo : str

# set test 3
SetTest3: TypeAlias = Set[SetTest3Values]

# map test 0
MapTest0: TypeAlias = Dict[str,str]

# map test 1
MapTest1: TypeAlias = Dict[str,str]

# map test 2
MapTest2: TypeAlias = Dict[str,Dict[str,str]]


class MapTest3Keys(BaseModel):# a keys record inside a map
    foo : str


class MapTest3Values(BaseModel):# a values record inside a map
    foo : str

# map test 3
MapTest3: TypeAlias = Dict[MapTest3Keys,MapTest3Values]

# oneOf test 0
OneOfTest0: TypeAlias = Union[str,int]

# oneOf test 1
OneOfTest1: TypeAlias = Union[str,int]


class OneOfTest2Option2(BaseModel):
    bar : float
    foo : str

# oneOf test 2
OneOfTest2: TypeAlias = Union[str,int,OneOfTest2Option2]

# oneOf test 3
OneOfTest3: TypeAlias = Union[Foo,Bar]


class AllOfTest0Option0(BaseModel):
    bar : float


class AllOfTest0Option1(BaseModel):
    foo : str

# allOf test 0
AllOfTest0: TypeAlias = Annotated[Any,_check_all_of(TypeAdapter(AllOfTest0Option0),TypeAdapter(AllOfTest0Option1))]

# tuple test 0
TupleTest0: TypeAlias = Tuple[str,int]

# tuple test 1
TupleTest1: TypeAlias = Tuple[str,int]

# tuple test 2
TupleTest2: TypeAlias = Tuple[str,Tuple[str,int]]

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
    email : Optional[str]
    phone : Optional[str]

# record test 2
class RecordTest2(BaseModel):# a record with an embedded record
    age : int
    contact : RecordTest2Contact
    deceased : bool
    name : str

# record test 3
class RecordTest3(BaseModel):# a record with optional props
    name : str
    age : Optional[int]
    deceased : Optional[bool]

# record test 4
class RecordTest4(Protocol):
    id : str
    status : str
    age : Optional[int]

# function test 0
FunctionTest0: TypeAlias = Callable[[],None]

# function test 1
FunctionTest1: TypeAlias = Callable[[],Awaitable[None]]

# function test 2
FunctionTest2: TypeAlias = Callable[[bool],None]

# function test 3
FunctionTest3: TypeAlias = Callable[[bool],Awaitable[None]]

# function test 4
FunctionTest4: TypeAlias = Callable[[bool,float,str],None]

# function test 5
FunctionTest5: TypeAlias = Callable[[bool,float,str],Awaitable[None]]

# function test 6
FunctionTest6: TypeAlias = Callable[[],None]

# function test 7
FunctionTest7: TypeAlias = Callable[[],Awaitable[None]]

# function test 8
FunctionTest8: TypeAlias = Callable[[],bool]

# function test 9
FunctionTest9: TypeAlias = Callable[[],Awaitable[bool]]

# function test 10
FunctionTest10: TypeAlias = Callable[[],[bool,float,str]]

# function test 11
FunctionTest11: TypeAlias = Callable[[],Awaitable[[bool,float,str]]]

# function test 12
FunctionTest12: TypeAlias = Callable[[int,str],[str,bool]]

# function test 13
FunctionTest13: TypeAlias = Callable[[int,str],Awaitable[[str,bool]]]


class FunctionTest14Input(BaseModel):
    bar : str
    foo : int


class FunctionTest14Output(BaseModel):
    bar : str
    foo : int

# function test 14
FunctionTest14: TypeAlias = Callable[[FunctionTest14Input],Awaitable[FunctionTest14Output]]


class FunctionTest15Input0(BaseModel):
    bar : str
    foo : int


class FunctionTest15Input1(BaseModel):
    bar : str
    foo : int


class FunctionTest15Output0(BaseModel):
    bar : str
    foo : int


class FunctionTest15Output1(BaseModel):
    bar : str
    foo : int

# function test 15
FunctionTest15: TypeAlias = Callable[[FunctionTest15Input0,FunctionTest15Input1],Awaitable[[FunctionTest15Output0,FunctionTest15Output1]]]

