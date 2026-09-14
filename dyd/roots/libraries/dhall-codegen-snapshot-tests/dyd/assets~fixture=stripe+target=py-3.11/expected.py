from __future__ import annotations

from collections.abc import Awaitable, Callable
from datetime import date, datetime, time
from typing import Annotated, Any, Literal, Protocol, TypeAlias

from pydantic import BaseModel, TypeAdapter

# used to simulate intersection type
def _check_all_of(*adapters: TypeAdapter[Any]):
    def check(v: Any) -> Any:
        for ta in adapters:
            ta.validate_python(v)  # raises on failure
        return v
    return check


class StripeAddress(BaseModel):
    city : (str) | None = None
    country : (str) | None = None
    line1 : (str) | None = None
    line2 : (str) | None = None
    postal_code : (str) | None = None
    state : (str) | None = None

class StripeCustomer(BaseModel):
    balance : int
    created : int
    id : str
    object : str
    address : (StripeAddress) | None = None
    currency : (str) | None = None
    description : (str) | None = None
    email : (str) | None = None
    name : (str) | None = None

class StripeChargeBillingDetails(BaseModel):
    address : (StripeAddress) | None = None
    email : (str) | None = None
    name : (str) | None = None
    phone : (str) | None = None

class StripeChargeOutcomeValue(BaseModel):
    type : str
    advice_code : (str) | None = None
    network_advice_code : (str) | None = None
    network_decline_code : (str) | None = None
    network_status : (str) | None = None
    reason : (str) | None = None
    risk_level : (str) | None = None
    risk_score : (int) | None = None
    rule : (str) | None = None
    seller_message : (str) | None = None

class StripeCharge(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeChargeBillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : (str) | None = None
    outcome : (StripeChargeOutcomeValue) | None = None
    refunds : ((list[str] | list[StripeRefund])) | None = None

class StripeRefund(BaseModel):
    amount : int
    charge : (str | StripeCharge)
    id : str
    object : str