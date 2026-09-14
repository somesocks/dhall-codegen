from __future__ import annotations

from datetime import date, datetime, time
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
    city : Optional[str] = None
    country : Optional[str] = None
    line1 : Optional[str] = None
    line2 : Optional[str] = None
    postal_code : Optional[str] = None
    state : Optional[str] = None

class StripeCustomer(BaseModel):
    balance : int
    created : int
    id : str
    object : str
    address : Optional[StripeAddress] = None
    currency : Optional[str] = None
    description : Optional[str] = None
    email : Optional[str] = None
    name : Optional[str] = None

class StripeChargeBillingDetails(BaseModel):
    address : Optional[StripeAddress] = None
    email : Optional[str] = None
    name : Optional[str] = None
    phone : Optional[str] = None

class StripeChargeOutcomeValue(BaseModel):
    type : str
    advice_code : Optional[str] = None
    network_advice_code : Optional[str] = None
    network_decline_code : Optional[str] = None
    network_status : Optional[str] = None
    reason : Optional[str] = None
    risk_level : Optional[str] = None
    risk_score : Optional[int] = None
    rule : Optional[str] = None
    seller_message : Optional[str] = None

class StripeCharge(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeChargeBillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str] = None
    outcome : Optional[StripeChargeOutcomeValue] = None
    refunds : Optional[Union[List[str],List[StripeRefund]]] = None

class StripeRefund(BaseModel):
    amount : int
    charge : Union[str,StripeCharge]
    id : str
    object : str