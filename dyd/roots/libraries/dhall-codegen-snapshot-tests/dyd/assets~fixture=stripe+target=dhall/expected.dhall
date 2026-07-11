
let Any : Type = ∀(R : Type) → (∀(A : Type) → A → R) → R

let StripeAddress =
  {
    city : Optional 
      Text,
    country : Optional 
      Text,
    line1 : Optional 
      Text,
    line2 : Optional 
      Text,
    postal_code : Optional 
      Text,
    state : Optional 
      Text
  }

let StripeCustomer =
  {
    balance :
      Integer,
    created :
      Integer,
    id :
      Text,
    object :
      {- must be string 'customer' -}
      Text,
    address : Optional 
      StripeAddress,
    currency : Optional 
      Text,
    description : Optional 
      Text,
    email : Optional 
      {- email address -}
      Text,
    name : Optional 
      {- customer name -}
      Text
  }

let StripeChargeBillingDetails =
  {
    address : Optional 
      StripeAddress,
    email : Optional 
      {- email address -}
      Text,
    name : Optional 
      {- customer name -}
      Text,
    phone : Optional 
      Text
  }

let StripeChargeOutcomeValue =
  {
    type :
      Text,
    advice_code : Optional 
      Text,
    network_advice_code : Optional 
      Text,
    network_decline_code : Optional 
      Text,
    network_status : Optional 
      Text,
    reason : Optional 
      Text,
    risk_level : Optional 
      Text,
    risk_score : Optional 
      Integer,
    rule : Optional 
      Text,
    seller_message : Optional 
      Text
  }

let StripeCharge =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeChargeBillingDetails,
    captured :
      Bool,
    created :
      {- Time at which the object was created. Measured in seconds since the Unix epoch. -}
      Integer,
    id :
      Text,
    object :
      {- must be string 'charge' -}
      Text,
    currency : Optional 
      Text,
    outcome : Optional 
      StripeChargeOutcomeValue,
    refunds : Optional 
      <
        Option0 :
          (
            List
              Text
          ) |
        Option1 :
          (
            List
              StripeRefund
          )
      >
  }

let StripeRefund =
  {
    amount :
      Integer,
    charge :
      <
        Option0 :
          Text |
        Option1 :
          StripeCharge
      >,
    id :
      Text,
    object :
      {- must be string 'refund' -}
      Text
  }

in {
  StripeAddress,
  StripeCustomer,
  StripeChargeBillingDetails,
  StripeChargeOutcomeValue,
  StripeCharge,
  StripeRefund
}