
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




class StripeAddress(BaseModel):
    city : Optional[str]
    country : Optional[str]
    line1 : Optional[str]
    line2 : Optional[str]
    postal_code : Optional[str]
    state : Optional[str]


class StripeCustomer(BaseModel):
    balance : int
    created : int
    id : str
    object : str
    address : Optional[StripeAddress]
    currency : Optional[str]
    description : Optional[str]
    email : Optional[str]
    name : Optional[str]


class StripeChargeBillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeChargeOutcomeValue(BaseModel):
    type : str
    advice_code : Optional[str]
    network_advice_code : Optional[str]
    network_decline_code : Optional[str]
    network_status : Optional[str]
    reason : Optional[str]
    risk_level : Optional[str]
    risk_score : Optional[int]
    rule : Optional[str]
    seller_message : Optional[str]


class StripeCharge(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeChargeBillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeChargeOutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeRefund(BaseModel):
    amount : int
    charge : Union[str,StripeCharge]
    id : str
    object : str

