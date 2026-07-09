
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


class StripeCharge0BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge0OutcomeValue(BaseModel):
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


class StripeCharge0(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge0BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge0OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge1BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge1OutcomeValue(BaseModel):
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


class StripeCharge1(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge1BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge1OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge2BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge2OutcomeValue(BaseModel):
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


class StripeCharge2(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge2BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge2OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge3BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge3OutcomeValue(BaseModel):
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


class StripeCharge3(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge3BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge3OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge4BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge4OutcomeValue(BaseModel):
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


class StripeCharge4(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge4BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge4OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge5BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge5OutcomeValue(BaseModel):
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


class StripeCharge5(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge5BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge5OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge6BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge6OutcomeValue(BaseModel):
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


class StripeCharge6(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge6BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge6OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge7BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge7OutcomeValue(BaseModel):
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


class StripeCharge7(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge7BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge7OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge8BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge8OutcomeValue(BaseModel):
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


class StripeCharge8(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge8BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge8OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge9BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge9OutcomeValue(BaseModel):
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


class StripeCharge9(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge9BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge9OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge10BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge10OutcomeValue(BaseModel):
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


class StripeCharge10(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge10BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge10OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge11BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge11OutcomeValue(BaseModel):
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


class StripeCharge11(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge11BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge11OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge12BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge12OutcomeValue(BaseModel):
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


class StripeCharge12(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge12BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge12OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge13BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge13OutcomeValue(BaseModel):
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


class StripeCharge13(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge13BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge13OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge14BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge14OutcomeValue(BaseModel):
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


class StripeCharge14(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge14BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge14OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge15BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge15OutcomeValue(BaseModel):
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


class StripeCharge15(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge15BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge15OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge16BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge16OutcomeValue(BaseModel):
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


class StripeCharge16(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge16BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge16OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge17BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge17OutcomeValue(BaseModel):
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


class StripeCharge17(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge17BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge17OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge18BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge18OutcomeValue(BaseModel):
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


class StripeCharge18(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge18BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge18OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge19BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge19OutcomeValue(BaseModel):
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


class StripeCharge19(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge19BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge19OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge20BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge20OutcomeValue(BaseModel):
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


class StripeCharge20(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge20BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge20OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge21BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge21OutcomeValue(BaseModel):
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


class StripeCharge21(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge21BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge21OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge22BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge22OutcomeValue(BaseModel):
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


class StripeCharge22(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge22BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge22OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge23BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge23OutcomeValue(BaseModel):
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


class StripeCharge23(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge23BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge23OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge24BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge24OutcomeValue(BaseModel):
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


class StripeCharge24(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge24BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge24OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge25BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge25OutcomeValue(BaseModel):
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


class StripeCharge25(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge25BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge25OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge26BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge26OutcomeValue(BaseModel):
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


class StripeCharge26(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge26BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge26OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge27BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge27OutcomeValue(BaseModel):
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


class StripeCharge27(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge27BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge27OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge28BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge28OutcomeValue(BaseModel):
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


class StripeCharge28(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge28BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge28OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge29BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge29OutcomeValue(BaseModel):
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


class StripeCharge29(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge29BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge29OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge30BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge30OutcomeValue(BaseModel):
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


class StripeCharge30(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge30BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge30OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge31BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge31OutcomeValue(BaseModel):
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


class StripeCharge31(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge31BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge31OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge32BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge32OutcomeValue(BaseModel):
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


class StripeCharge32(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge32BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge32OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge33BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge33OutcomeValue(BaseModel):
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


class StripeCharge33(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge33BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge33OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge34BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge34OutcomeValue(BaseModel):
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


class StripeCharge34(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge34BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge34OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge35BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge35OutcomeValue(BaseModel):
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


class StripeCharge35(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge35BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge35OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge36BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge36OutcomeValue(BaseModel):
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


class StripeCharge36(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge36BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge36OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge37BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge37OutcomeValue(BaseModel):
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


class StripeCharge37(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge37BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge37OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge38BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge38OutcomeValue(BaseModel):
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


class StripeCharge38(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge38BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge38OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge39BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge39OutcomeValue(BaseModel):
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


class StripeCharge39(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge39BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge39OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge40BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge40OutcomeValue(BaseModel):
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


class StripeCharge40(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge40BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge40OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge41BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge41OutcomeValue(BaseModel):
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


class StripeCharge41(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge41BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge41OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge42BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge42OutcomeValue(BaseModel):
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


class StripeCharge42(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge42BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge42OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge43BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge43OutcomeValue(BaseModel):
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


class StripeCharge43(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge43BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge43OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge44BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge44OutcomeValue(BaseModel):
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


class StripeCharge44(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge44BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge44OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge45BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge45OutcomeValue(BaseModel):
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


class StripeCharge45(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge45BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge45OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge46BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge46OutcomeValue(BaseModel):
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


class StripeCharge46(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge46BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge46OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge47BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge47OutcomeValue(BaseModel):
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


class StripeCharge47(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge47BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge47OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge48BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge48OutcomeValue(BaseModel):
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


class StripeCharge48(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge48BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge48OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge49BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge49OutcomeValue(BaseModel):
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


class StripeCharge49(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge49BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge49OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge50BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge50OutcomeValue(BaseModel):
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


class StripeCharge50(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge50BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge50OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge51BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge51OutcomeValue(BaseModel):
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


class StripeCharge51(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge51BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge51OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge52BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge52OutcomeValue(BaseModel):
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


class StripeCharge52(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge52BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge52OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge53BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge53OutcomeValue(BaseModel):
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


class StripeCharge53(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge53BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge53OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge54BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge54OutcomeValue(BaseModel):
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


class StripeCharge54(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge54BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge54OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge55BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge55OutcomeValue(BaseModel):
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


class StripeCharge55(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge55BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge55OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge56BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge56OutcomeValue(BaseModel):
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


class StripeCharge56(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge56BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge56OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge57BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge57OutcomeValue(BaseModel):
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


class StripeCharge57(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge57BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge57OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge58BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge58OutcomeValue(BaseModel):
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


class StripeCharge58(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge58BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge58OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge59BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge59OutcomeValue(BaseModel):
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


class StripeCharge59(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge59BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge59OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge60BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge60OutcomeValue(BaseModel):
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


class StripeCharge60(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge60BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge60OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge61BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge61OutcomeValue(BaseModel):
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


class StripeCharge61(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge61BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge61OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge62BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge62OutcomeValue(BaseModel):
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


class StripeCharge62(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge62BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge62OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge63BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge63OutcomeValue(BaseModel):
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


class StripeCharge63(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge63BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge63OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge64BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge64OutcomeValue(BaseModel):
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


class StripeCharge64(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge64BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge64OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge65BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge65OutcomeValue(BaseModel):
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


class StripeCharge65(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge65BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge65OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge66BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge66OutcomeValue(BaseModel):
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


class StripeCharge66(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge66BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge66OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge67BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge67OutcomeValue(BaseModel):
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


class StripeCharge67(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge67BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge67OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge68BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge68OutcomeValue(BaseModel):
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


class StripeCharge68(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge68BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge68OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge69BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge69OutcomeValue(BaseModel):
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


class StripeCharge69(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge69BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge69OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge70BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge70OutcomeValue(BaseModel):
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


class StripeCharge70(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge70BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge70OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge71BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge71OutcomeValue(BaseModel):
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


class StripeCharge71(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge71BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge71OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge72BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge72OutcomeValue(BaseModel):
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


class StripeCharge72(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge72BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge72OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge73BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge73OutcomeValue(BaseModel):
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


class StripeCharge73(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge73BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge73OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge74BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge74OutcomeValue(BaseModel):
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


class StripeCharge74(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge74BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge74OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge75BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge75OutcomeValue(BaseModel):
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


class StripeCharge75(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge75BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge75OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge76BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge76OutcomeValue(BaseModel):
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


class StripeCharge76(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge76BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge76OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge77BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge77OutcomeValue(BaseModel):
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


class StripeCharge77(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge77BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge77OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge78BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge78OutcomeValue(BaseModel):
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


class StripeCharge78(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge78BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge78OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge79BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge79OutcomeValue(BaseModel):
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


class StripeCharge79(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge79BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge79OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge80BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge80OutcomeValue(BaseModel):
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


class StripeCharge80(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge80BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge80OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge81BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge81OutcomeValue(BaseModel):
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


class StripeCharge81(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge81BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge81OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge82BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge82OutcomeValue(BaseModel):
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


class StripeCharge82(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge82BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge82OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge83BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge83OutcomeValue(BaseModel):
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


class StripeCharge83(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge83BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge83OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge84BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge84OutcomeValue(BaseModel):
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


class StripeCharge84(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge84BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge84OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge85BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge85OutcomeValue(BaseModel):
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


class StripeCharge85(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge85BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge85OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge86BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge86OutcomeValue(BaseModel):
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


class StripeCharge86(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge86BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge86OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge87BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge87OutcomeValue(BaseModel):
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


class StripeCharge87(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge87BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge87OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge88BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge88OutcomeValue(BaseModel):
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


class StripeCharge88(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge88BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge88OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge89BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge89OutcomeValue(BaseModel):
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


class StripeCharge89(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge89BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge89OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge90BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge90OutcomeValue(BaseModel):
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


class StripeCharge90(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge90BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge90OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge91BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge91OutcomeValue(BaseModel):
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


class StripeCharge91(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge91BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge91OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge92BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge92OutcomeValue(BaseModel):
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


class StripeCharge92(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge92BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge92OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge93BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge93OutcomeValue(BaseModel):
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


class StripeCharge93(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge93BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge93OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge94BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge94OutcomeValue(BaseModel):
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


class StripeCharge94(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge94BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge94OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge95BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge95OutcomeValue(BaseModel):
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


class StripeCharge95(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge95BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge95OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge96BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge96OutcomeValue(BaseModel):
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


class StripeCharge96(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge96BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge96OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge97BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge97OutcomeValue(BaseModel):
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


class StripeCharge97(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge97BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge97OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge98BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge98OutcomeValue(BaseModel):
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


class StripeCharge98(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge98BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge98OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]


class StripeCharge99BillingDetails(BaseModel):
    address : Optional[StripeAddress]
    email : Optional[str]
    name : Optional[str]
    phone : Optional[str]


class StripeCharge99OutcomeValue(BaseModel):
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


class StripeCharge99(BaseModel):
    amount : int
    amount_captured : int
    amount_refunded : int
    billing_details : StripeCharge99BillingDetails
    captured : bool
    created : int
    id : str
    object : str
    currency : Optional[str]
    outcome : Optional[StripeCharge99OutcomeValue]
    refunds : Optional[Union[List[str],List[StripeRefund]]]

