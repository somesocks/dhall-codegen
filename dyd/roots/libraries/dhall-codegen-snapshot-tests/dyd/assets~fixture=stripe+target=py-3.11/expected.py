from __future__ import annotations

from collections.abc import Awaitable, Callable
from datetime import datetime
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
    city : (str) | None
    country : (str) | None
    line1 : (str) | None
    line2 : (str) | None
    postal_code : (str) | None
    state : (str) | None

class StripeCustomer(BaseModel):
    balance : int
    created : int
    id : str
    object : str
    address : (StripeAddress) | None
    currency : (str) | None
    description : (str) | None
    email : (str) | None
    name : (str) | None

class StripeChargeBillingDetails(BaseModel):
    address : (StripeAddress) | None
    email : (str) | None
    name : (str) | None
    phone : (str) | None

class StripeChargeOutcomeValue(BaseModel):
    type : str
    advice_code : (str) | None
    network_advice_code : (str) | None
    network_decline_code : (str) | None
    network_status : (str) | None
    reason : (str) | None
    risk_level : (str) | None
    risk_score : (int) | None
    rule : (str) | None
    seller_message : (str) | None

class StripeCharge(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeChargeBillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : (str) | None
    outcome : (StripeChargeOutcomeValue) | None
    refunds : ((list[str] | list[StripeRefund])) | None

class StripeRefund(BaseModel):
    amount : int
    charge : (str | StripeCharge)
    id : str
    object : str