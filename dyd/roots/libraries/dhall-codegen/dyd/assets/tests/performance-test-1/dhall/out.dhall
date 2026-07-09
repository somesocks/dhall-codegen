
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

let StripeCharge0BillingDetails =
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

let StripeCharge0OutcomeValue =
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

let StripeCharge0 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge0BillingDetails,
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
      StripeCharge0OutcomeValue,
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

let StripeCharge1BillingDetails =
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

let StripeCharge1OutcomeValue =
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

let StripeCharge1 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge1BillingDetails,
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
      StripeCharge1OutcomeValue,
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

let StripeCharge2BillingDetails =
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

let StripeCharge2OutcomeValue =
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

let StripeCharge2 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge2BillingDetails,
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
      StripeCharge2OutcomeValue,
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

let StripeCharge3BillingDetails =
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

let StripeCharge3OutcomeValue =
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

let StripeCharge3 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge3BillingDetails,
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
      StripeCharge3OutcomeValue,
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

let StripeCharge4BillingDetails =
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

let StripeCharge4OutcomeValue =
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

let StripeCharge4 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge4BillingDetails,
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
      StripeCharge4OutcomeValue,
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

let StripeCharge5BillingDetails =
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

let StripeCharge5OutcomeValue =
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

let StripeCharge5 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge5BillingDetails,
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
      StripeCharge5OutcomeValue,
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

let StripeCharge6BillingDetails =
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

let StripeCharge6OutcomeValue =
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

let StripeCharge6 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge6BillingDetails,
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
      StripeCharge6OutcomeValue,
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

let StripeCharge7BillingDetails =
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

let StripeCharge7OutcomeValue =
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

let StripeCharge7 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge7BillingDetails,
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
      StripeCharge7OutcomeValue,
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

let StripeCharge8BillingDetails =
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

let StripeCharge8OutcomeValue =
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

let StripeCharge8 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge8BillingDetails,
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
      StripeCharge8OutcomeValue,
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

let StripeCharge9BillingDetails =
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

let StripeCharge9OutcomeValue =
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

let StripeCharge9 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge9BillingDetails,
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
      StripeCharge9OutcomeValue,
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

let StripeCharge10BillingDetails =
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

let StripeCharge10OutcomeValue =
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

let StripeCharge10 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge10BillingDetails,
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
      StripeCharge10OutcomeValue,
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

let StripeCharge11BillingDetails =
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

let StripeCharge11OutcomeValue =
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

let StripeCharge11 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge11BillingDetails,
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
      StripeCharge11OutcomeValue,
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

let StripeCharge12BillingDetails =
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

let StripeCharge12OutcomeValue =
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

let StripeCharge12 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge12BillingDetails,
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
      StripeCharge12OutcomeValue,
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

let StripeCharge13BillingDetails =
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

let StripeCharge13OutcomeValue =
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

let StripeCharge13 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge13BillingDetails,
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
      StripeCharge13OutcomeValue,
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

let StripeCharge14BillingDetails =
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

let StripeCharge14OutcomeValue =
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

let StripeCharge14 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge14BillingDetails,
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
      StripeCharge14OutcomeValue,
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

let StripeCharge15BillingDetails =
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

let StripeCharge15OutcomeValue =
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

let StripeCharge15 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge15BillingDetails,
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
      StripeCharge15OutcomeValue,
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

let StripeCharge16BillingDetails =
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

let StripeCharge16OutcomeValue =
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

let StripeCharge16 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge16BillingDetails,
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
      StripeCharge16OutcomeValue,
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

let StripeCharge17BillingDetails =
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

let StripeCharge17OutcomeValue =
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

let StripeCharge17 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge17BillingDetails,
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
      StripeCharge17OutcomeValue,
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

let StripeCharge18BillingDetails =
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

let StripeCharge18OutcomeValue =
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

let StripeCharge18 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge18BillingDetails,
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
      StripeCharge18OutcomeValue,
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

let StripeCharge19BillingDetails =
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

let StripeCharge19OutcomeValue =
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

let StripeCharge19 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge19BillingDetails,
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
      StripeCharge19OutcomeValue,
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

let StripeCharge20BillingDetails =
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

let StripeCharge20OutcomeValue =
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

let StripeCharge20 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge20BillingDetails,
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
      StripeCharge20OutcomeValue,
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

let StripeCharge21BillingDetails =
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

let StripeCharge21OutcomeValue =
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

let StripeCharge21 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge21BillingDetails,
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
      StripeCharge21OutcomeValue,
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

let StripeCharge22BillingDetails =
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

let StripeCharge22OutcomeValue =
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

let StripeCharge22 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge22BillingDetails,
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
      StripeCharge22OutcomeValue,
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

let StripeCharge23BillingDetails =
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

let StripeCharge23OutcomeValue =
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

let StripeCharge23 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge23BillingDetails,
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
      StripeCharge23OutcomeValue,
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

let StripeCharge24BillingDetails =
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

let StripeCharge24OutcomeValue =
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

let StripeCharge24 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge24BillingDetails,
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
      StripeCharge24OutcomeValue,
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

let StripeCharge25BillingDetails =
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

let StripeCharge25OutcomeValue =
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

let StripeCharge25 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge25BillingDetails,
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
      StripeCharge25OutcomeValue,
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

let StripeCharge26BillingDetails =
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

let StripeCharge26OutcomeValue =
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

let StripeCharge26 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge26BillingDetails,
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
      StripeCharge26OutcomeValue,
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

let StripeCharge27BillingDetails =
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

let StripeCharge27OutcomeValue =
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

let StripeCharge27 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge27BillingDetails,
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
      StripeCharge27OutcomeValue,
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

let StripeCharge28BillingDetails =
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

let StripeCharge28OutcomeValue =
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

let StripeCharge28 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge28BillingDetails,
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
      StripeCharge28OutcomeValue,
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

let StripeCharge29BillingDetails =
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

let StripeCharge29OutcomeValue =
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

let StripeCharge29 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge29BillingDetails,
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
      StripeCharge29OutcomeValue,
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

let StripeCharge30BillingDetails =
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

let StripeCharge30OutcomeValue =
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

let StripeCharge30 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge30BillingDetails,
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
      StripeCharge30OutcomeValue,
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

let StripeCharge31BillingDetails =
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

let StripeCharge31OutcomeValue =
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

let StripeCharge31 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge31BillingDetails,
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
      StripeCharge31OutcomeValue,
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

let StripeCharge32BillingDetails =
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

let StripeCharge32OutcomeValue =
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

let StripeCharge32 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge32BillingDetails,
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
      StripeCharge32OutcomeValue,
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

let StripeCharge33BillingDetails =
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

let StripeCharge33OutcomeValue =
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

let StripeCharge33 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge33BillingDetails,
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
      StripeCharge33OutcomeValue,
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

let StripeCharge34BillingDetails =
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

let StripeCharge34OutcomeValue =
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

let StripeCharge34 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge34BillingDetails,
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
      StripeCharge34OutcomeValue,
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

let StripeCharge35BillingDetails =
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

let StripeCharge35OutcomeValue =
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

let StripeCharge35 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge35BillingDetails,
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
      StripeCharge35OutcomeValue,
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

let StripeCharge36BillingDetails =
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

let StripeCharge36OutcomeValue =
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

let StripeCharge36 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge36BillingDetails,
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
      StripeCharge36OutcomeValue,
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

let StripeCharge37BillingDetails =
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

let StripeCharge37OutcomeValue =
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

let StripeCharge37 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge37BillingDetails,
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
      StripeCharge37OutcomeValue,
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

let StripeCharge38BillingDetails =
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

let StripeCharge38OutcomeValue =
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

let StripeCharge38 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge38BillingDetails,
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
      StripeCharge38OutcomeValue,
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

let StripeCharge39BillingDetails =
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

let StripeCharge39OutcomeValue =
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

let StripeCharge39 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge39BillingDetails,
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
      StripeCharge39OutcomeValue,
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

let StripeCharge40BillingDetails =
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

let StripeCharge40OutcomeValue =
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

let StripeCharge40 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge40BillingDetails,
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
      StripeCharge40OutcomeValue,
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

let StripeCharge41BillingDetails =
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

let StripeCharge41OutcomeValue =
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

let StripeCharge41 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge41BillingDetails,
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
      StripeCharge41OutcomeValue,
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

let StripeCharge42BillingDetails =
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

let StripeCharge42OutcomeValue =
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

let StripeCharge42 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge42BillingDetails,
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
      StripeCharge42OutcomeValue,
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

let StripeCharge43BillingDetails =
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

let StripeCharge43OutcomeValue =
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

let StripeCharge43 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge43BillingDetails,
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
      StripeCharge43OutcomeValue,
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

let StripeCharge44BillingDetails =
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

let StripeCharge44OutcomeValue =
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

let StripeCharge44 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge44BillingDetails,
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
      StripeCharge44OutcomeValue,
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

let StripeCharge45BillingDetails =
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

let StripeCharge45OutcomeValue =
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

let StripeCharge45 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge45BillingDetails,
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
      StripeCharge45OutcomeValue,
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

let StripeCharge46BillingDetails =
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

let StripeCharge46OutcomeValue =
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

let StripeCharge46 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge46BillingDetails,
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
      StripeCharge46OutcomeValue,
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

let StripeCharge47BillingDetails =
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

let StripeCharge47OutcomeValue =
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

let StripeCharge47 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge47BillingDetails,
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
      StripeCharge47OutcomeValue,
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

let StripeCharge48BillingDetails =
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

let StripeCharge48OutcomeValue =
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

let StripeCharge48 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge48BillingDetails,
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
      StripeCharge48OutcomeValue,
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

let StripeCharge49BillingDetails =
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

let StripeCharge49OutcomeValue =
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

let StripeCharge49 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge49BillingDetails,
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
      StripeCharge49OutcomeValue,
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

let StripeCharge50BillingDetails =
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

let StripeCharge50OutcomeValue =
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

let StripeCharge50 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge50BillingDetails,
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
      StripeCharge50OutcomeValue,
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

let StripeCharge51BillingDetails =
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

let StripeCharge51OutcomeValue =
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

let StripeCharge51 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge51BillingDetails,
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
      StripeCharge51OutcomeValue,
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

let StripeCharge52BillingDetails =
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

let StripeCharge52OutcomeValue =
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

let StripeCharge52 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge52BillingDetails,
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
      StripeCharge52OutcomeValue,
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

let StripeCharge53BillingDetails =
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

let StripeCharge53OutcomeValue =
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

let StripeCharge53 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge53BillingDetails,
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
      StripeCharge53OutcomeValue,
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

let StripeCharge54BillingDetails =
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

let StripeCharge54OutcomeValue =
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

let StripeCharge54 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge54BillingDetails,
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
      StripeCharge54OutcomeValue,
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

let StripeCharge55BillingDetails =
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

let StripeCharge55OutcomeValue =
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

let StripeCharge55 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge55BillingDetails,
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
      StripeCharge55OutcomeValue,
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

let StripeCharge56BillingDetails =
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

let StripeCharge56OutcomeValue =
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

let StripeCharge56 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge56BillingDetails,
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
      StripeCharge56OutcomeValue,
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

let StripeCharge57BillingDetails =
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

let StripeCharge57OutcomeValue =
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

let StripeCharge57 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge57BillingDetails,
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
      StripeCharge57OutcomeValue,
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

let StripeCharge58BillingDetails =
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

let StripeCharge58OutcomeValue =
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

let StripeCharge58 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge58BillingDetails,
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
      StripeCharge58OutcomeValue,
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

let StripeCharge59BillingDetails =
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

let StripeCharge59OutcomeValue =
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

let StripeCharge59 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge59BillingDetails,
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
      StripeCharge59OutcomeValue,
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

let StripeCharge60BillingDetails =
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

let StripeCharge60OutcomeValue =
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

let StripeCharge60 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge60BillingDetails,
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
      StripeCharge60OutcomeValue,
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

let StripeCharge61BillingDetails =
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

let StripeCharge61OutcomeValue =
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

let StripeCharge61 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge61BillingDetails,
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
      StripeCharge61OutcomeValue,
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

let StripeCharge62BillingDetails =
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

let StripeCharge62OutcomeValue =
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

let StripeCharge62 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge62BillingDetails,
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
      StripeCharge62OutcomeValue,
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

let StripeCharge63BillingDetails =
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

let StripeCharge63OutcomeValue =
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

let StripeCharge63 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge63BillingDetails,
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
      StripeCharge63OutcomeValue,
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

let StripeCharge64BillingDetails =
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

let StripeCharge64OutcomeValue =
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

let StripeCharge64 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge64BillingDetails,
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
      StripeCharge64OutcomeValue,
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

let StripeCharge65BillingDetails =
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

let StripeCharge65OutcomeValue =
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

let StripeCharge65 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge65BillingDetails,
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
      StripeCharge65OutcomeValue,
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

let StripeCharge66BillingDetails =
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

let StripeCharge66OutcomeValue =
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

let StripeCharge66 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge66BillingDetails,
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
      StripeCharge66OutcomeValue,
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

let StripeCharge67BillingDetails =
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

let StripeCharge67OutcomeValue =
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

let StripeCharge67 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge67BillingDetails,
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
      StripeCharge67OutcomeValue,
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

let StripeCharge68BillingDetails =
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

let StripeCharge68OutcomeValue =
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

let StripeCharge68 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge68BillingDetails,
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
      StripeCharge68OutcomeValue,
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

let StripeCharge69BillingDetails =
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

let StripeCharge69OutcomeValue =
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

let StripeCharge69 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge69BillingDetails,
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
      StripeCharge69OutcomeValue,
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

let StripeCharge70BillingDetails =
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

let StripeCharge70OutcomeValue =
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

let StripeCharge70 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge70BillingDetails,
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
      StripeCharge70OutcomeValue,
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

let StripeCharge71BillingDetails =
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

let StripeCharge71OutcomeValue =
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

let StripeCharge71 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge71BillingDetails,
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
      StripeCharge71OutcomeValue,
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

let StripeCharge72BillingDetails =
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

let StripeCharge72OutcomeValue =
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

let StripeCharge72 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge72BillingDetails,
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
      StripeCharge72OutcomeValue,
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

let StripeCharge73BillingDetails =
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

let StripeCharge73OutcomeValue =
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

let StripeCharge73 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge73BillingDetails,
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
      StripeCharge73OutcomeValue,
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

let StripeCharge74BillingDetails =
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

let StripeCharge74OutcomeValue =
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

let StripeCharge74 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge74BillingDetails,
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
      StripeCharge74OutcomeValue,
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

let StripeCharge75BillingDetails =
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

let StripeCharge75OutcomeValue =
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

let StripeCharge75 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge75BillingDetails,
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
      StripeCharge75OutcomeValue,
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

let StripeCharge76BillingDetails =
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

let StripeCharge76OutcomeValue =
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

let StripeCharge76 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge76BillingDetails,
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
      StripeCharge76OutcomeValue,
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

let StripeCharge77BillingDetails =
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

let StripeCharge77OutcomeValue =
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

let StripeCharge77 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge77BillingDetails,
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
      StripeCharge77OutcomeValue,
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

let StripeCharge78BillingDetails =
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

let StripeCharge78OutcomeValue =
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

let StripeCharge78 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge78BillingDetails,
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
      StripeCharge78OutcomeValue,
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

let StripeCharge79BillingDetails =
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

let StripeCharge79OutcomeValue =
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

let StripeCharge79 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge79BillingDetails,
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
      StripeCharge79OutcomeValue,
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

let StripeCharge80BillingDetails =
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

let StripeCharge80OutcomeValue =
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

let StripeCharge80 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge80BillingDetails,
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
      StripeCharge80OutcomeValue,
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

let StripeCharge81BillingDetails =
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

let StripeCharge81OutcomeValue =
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

let StripeCharge81 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge81BillingDetails,
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
      StripeCharge81OutcomeValue,
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

let StripeCharge82BillingDetails =
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

let StripeCharge82OutcomeValue =
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

let StripeCharge82 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge82BillingDetails,
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
      StripeCharge82OutcomeValue,
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

let StripeCharge83BillingDetails =
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

let StripeCharge83OutcomeValue =
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

let StripeCharge83 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge83BillingDetails,
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
      StripeCharge83OutcomeValue,
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

let StripeCharge84BillingDetails =
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

let StripeCharge84OutcomeValue =
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

let StripeCharge84 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge84BillingDetails,
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
      StripeCharge84OutcomeValue,
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

let StripeCharge85BillingDetails =
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

let StripeCharge85OutcomeValue =
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

let StripeCharge85 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge85BillingDetails,
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
      StripeCharge85OutcomeValue,
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

let StripeCharge86BillingDetails =
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

let StripeCharge86OutcomeValue =
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

let StripeCharge86 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge86BillingDetails,
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
      StripeCharge86OutcomeValue,
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

let StripeCharge87BillingDetails =
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

let StripeCharge87OutcomeValue =
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

let StripeCharge87 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge87BillingDetails,
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
      StripeCharge87OutcomeValue,
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

let StripeCharge88BillingDetails =
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

let StripeCharge88OutcomeValue =
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

let StripeCharge88 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge88BillingDetails,
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
      StripeCharge88OutcomeValue,
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

let StripeCharge89BillingDetails =
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

let StripeCharge89OutcomeValue =
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

let StripeCharge89 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge89BillingDetails,
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
      StripeCharge89OutcomeValue,
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

let StripeCharge90BillingDetails =
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

let StripeCharge90OutcomeValue =
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

let StripeCharge90 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge90BillingDetails,
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
      StripeCharge90OutcomeValue,
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

let StripeCharge91BillingDetails =
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

let StripeCharge91OutcomeValue =
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

let StripeCharge91 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge91BillingDetails,
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
      StripeCharge91OutcomeValue,
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

let StripeCharge92BillingDetails =
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

let StripeCharge92OutcomeValue =
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

let StripeCharge92 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge92BillingDetails,
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
      StripeCharge92OutcomeValue,
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

let StripeCharge93BillingDetails =
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

let StripeCharge93OutcomeValue =
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

let StripeCharge93 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge93BillingDetails,
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
      StripeCharge93OutcomeValue,
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

let StripeCharge94BillingDetails =
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

let StripeCharge94OutcomeValue =
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

let StripeCharge94 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge94BillingDetails,
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
      StripeCharge94OutcomeValue,
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

let StripeCharge95BillingDetails =
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

let StripeCharge95OutcomeValue =
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

let StripeCharge95 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge95BillingDetails,
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
      StripeCharge95OutcomeValue,
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

let StripeCharge96BillingDetails =
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

let StripeCharge96OutcomeValue =
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

let StripeCharge96 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge96BillingDetails,
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
      StripeCharge96OutcomeValue,
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

let StripeCharge97BillingDetails =
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

let StripeCharge97OutcomeValue =
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

let StripeCharge97 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge97BillingDetails,
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
      StripeCharge97OutcomeValue,
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

let StripeCharge98BillingDetails =
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

let StripeCharge98OutcomeValue =
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

let StripeCharge98 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge98BillingDetails,
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
      StripeCharge98OutcomeValue,
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

let StripeCharge99BillingDetails =
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

let StripeCharge99OutcomeValue =
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

let StripeCharge99 =
  {
    amount :
      Integer,
    amount_captured :
      Integer,
    amount_refunded :
      Integer,
    billing_details :
      StripeCharge99BillingDetails,
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
      StripeCharge99OutcomeValue,
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

in {
  StripeAddress,
  StripeCharge0BillingDetails,
  StripeCharge0OutcomeValue,
  StripeCharge0,
  StripeCharge1BillingDetails,
  StripeCharge1OutcomeValue,
  StripeCharge1,
  StripeCharge2BillingDetails,
  StripeCharge2OutcomeValue,
  StripeCharge2,
  StripeCharge3BillingDetails,
  StripeCharge3OutcomeValue,
  StripeCharge3,
  StripeCharge4BillingDetails,
  StripeCharge4OutcomeValue,
  StripeCharge4,
  StripeCharge5BillingDetails,
  StripeCharge5OutcomeValue,
  StripeCharge5,
  StripeCharge6BillingDetails,
  StripeCharge6OutcomeValue,
  StripeCharge6,
  StripeCharge7BillingDetails,
  StripeCharge7OutcomeValue,
  StripeCharge7,
  StripeCharge8BillingDetails,
  StripeCharge8OutcomeValue,
  StripeCharge8,
  StripeCharge9BillingDetails,
  StripeCharge9OutcomeValue,
  StripeCharge9,
  StripeCharge10BillingDetails,
  StripeCharge10OutcomeValue,
  StripeCharge10,
  StripeCharge11BillingDetails,
  StripeCharge11OutcomeValue,
  StripeCharge11,
  StripeCharge12BillingDetails,
  StripeCharge12OutcomeValue,
  StripeCharge12,
  StripeCharge13BillingDetails,
  StripeCharge13OutcomeValue,
  StripeCharge13,
  StripeCharge14BillingDetails,
  StripeCharge14OutcomeValue,
  StripeCharge14,
  StripeCharge15BillingDetails,
  StripeCharge15OutcomeValue,
  StripeCharge15,
  StripeCharge16BillingDetails,
  StripeCharge16OutcomeValue,
  StripeCharge16,
  StripeCharge17BillingDetails,
  StripeCharge17OutcomeValue,
  StripeCharge17,
  StripeCharge18BillingDetails,
  StripeCharge18OutcomeValue,
  StripeCharge18,
  StripeCharge19BillingDetails,
  StripeCharge19OutcomeValue,
  StripeCharge19,
  StripeCharge20BillingDetails,
  StripeCharge20OutcomeValue,
  StripeCharge20,
  StripeCharge21BillingDetails,
  StripeCharge21OutcomeValue,
  StripeCharge21,
  StripeCharge22BillingDetails,
  StripeCharge22OutcomeValue,
  StripeCharge22,
  StripeCharge23BillingDetails,
  StripeCharge23OutcomeValue,
  StripeCharge23,
  StripeCharge24BillingDetails,
  StripeCharge24OutcomeValue,
  StripeCharge24,
  StripeCharge25BillingDetails,
  StripeCharge25OutcomeValue,
  StripeCharge25,
  StripeCharge26BillingDetails,
  StripeCharge26OutcomeValue,
  StripeCharge26,
  StripeCharge27BillingDetails,
  StripeCharge27OutcomeValue,
  StripeCharge27,
  StripeCharge28BillingDetails,
  StripeCharge28OutcomeValue,
  StripeCharge28,
  StripeCharge29BillingDetails,
  StripeCharge29OutcomeValue,
  StripeCharge29,
  StripeCharge30BillingDetails,
  StripeCharge30OutcomeValue,
  StripeCharge30,
  StripeCharge31BillingDetails,
  StripeCharge31OutcomeValue,
  StripeCharge31,
  StripeCharge32BillingDetails,
  StripeCharge32OutcomeValue,
  StripeCharge32,
  StripeCharge33BillingDetails,
  StripeCharge33OutcomeValue,
  StripeCharge33,
  StripeCharge34BillingDetails,
  StripeCharge34OutcomeValue,
  StripeCharge34,
  StripeCharge35BillingDetails,
  StripeCharge35OutcomeValue,
  StripeCharge35,
  StripeCharge36BillingDetails,
  StripeCharge36OutcomeValue,
  StripeCharge36,
  StripeCharge37BillingDetails,
  StripeCharge37OutcomeValue,
  StripeCharge37,
  StripeCharge38BillingDetails,
  StripeCharge38OutcomeValue,
  StripeCharge38,
  StripeCharge39BillingDetails,
  StripeCharge39OutcomeValue,
  StripeCharge39,
  StripeCharge40BillingDetails,
  StripeCharge40OutcomeValue,
  StripeCharge40,
  StripeCharge41BillingDetails,
  StripeCharge41OutcomeValue,
  StripeCharge41,
  StripeCharge42BillingDetails,
  StripeCharge42OutcomeValue,
  StripeCharge42,
  StripeCharge43BillingDetails,
  StripeCharge43OutcomeValue,
  StripeCharge43,
  StripeCharge44BillingDetails,
  StripeCharge44OutcomeValue,
  StripeCharge44,
  StripeCharge45BillingDetails,
  StripeCharge45OutcomeValue,
  StripeCharge45,
  StripeCharge46BillingDetails,
  StripeCharge46OutcomeValue,
  StripeCharge46,
  StripeCharge47BillingDetails,
  StripeCharge47OutcomeValue,
  StripeCharge47,
  StripeCharge48BillingDetails,
  StripeCharge48OutcomeValue,
  StripeCharge48,
  StripeCharge49BillingDetails,
  StripeCharge49OutcomeValue,
  StripeCharge49,
  StripeCharge50BillingDetails,
  StripeCharge50OutcomeValue,
  StripeCharge50,
  StripeCharge51BillingDetails,
  StripeCharge51OutcomeValue,
  StripeCharge51,
  StripeCharge52BillingDetails,
  StripeCharge52OutcomeValue,
  StripeCharge52,
  StripeCharge53BillingDetails,
  StripeCharge53OutcomeValue,
  StripeCharge53,
  StripeCharge54BillingDetails,
  StripeCharge54OutcomeValue,
  StripeCharge54,
  StripeCharge55BillingDetails,
  StripeCharge55OutcomeValue,
  StripeCharge55,
  StripeCharge56BillingDetails,
  StripeCharge56OutcomeValue,
  StripeCharge56,
  StripeCharge57BillingDetails,
  StripeCharge57OutcomeValue,
  StripeCharge57,
  StripeCharge58BillingDetails,
  StripeCharge58OutcomeValue,
  StripeCharge58,
  StripeCharge59BillingDetails,
  StripeCharge59OutcomeValue,
  StripeCharge59,
  StripeCharge60BillingDetails,
  StripeCharge60OutcomeValue,
  StripeCharge60,
  StripeCharge61BillingDetails,
  StripeCharge61OutcomeValue,
  StripeCharge61,
  StripeCharge62BillingDetails,
  StripeCharge62OutcomeValue,
  StripeCharge62,
  StripeCharge63BillingDetails,
  StripeCharge63OutcomeValue,
  StripeCharge63,
  StripeCharge64BillingDetails,
  StripeCharge64OutcomeValue,
  StripeCharge64,
  StripeCharge65BillingDetails,
  StripeCharge65OutcomeValue,
  StripeCharge65,
  StripeCharge66BillingDetails,
  StripeCharge66OutcomeValue,
  StripeCharge66,
  StripeCharge67BillingDetails,
  StripeCharge67OutcomeValue,
  StripeCharge67,
  StripeCharge68BillingDetails,
  StripeCharge68OutcomeValue,
  StripeCharge68,
  StripeCharge69BillingDetails,
  StripeCharge69OutcomeValue,
  StripeCharge69,
  StripeCharge70BillingDetails,
  StripeCharge70OutcomeValue,
  StripeCharge70,
  StripeCharge71BillingDetails,
  StripeCharge71OutcomeValue,
  StripeCharge71,
  StripeCharge72BillingDetails,
  StripeCharge72OutcomeValue,
  StripeCharge72,
  StripeCharge73BillingDetails,
  StripeCharge73OutcomeValue,
  StripeCharge73,
  StripeCharge74BillingDetails,
  StripeCharge74OutcomeValue,
  StripeCharge74,
  StripeCharge75BillingDetails,
  StripeCharge75OutcomeValue,
  StripeCharge75,
  StripeCharge76BillingDetails,
  StripeCharge76OutcomeValue,
  StripeCharge76,
  StripeCharge77BillingDetails,
  StripeCharge77OutcomeValue,
  StripeCharge77,
  StripeCharge78BillingDetails,
  StripeCharge78OutcomeValue,
  StripeCharge78,
  StripeCharge79BillingDetails,
  StripeCharge79OutcomeValue,
  StripeCharge79,
  StripeCharge80BillingDetails,
  StripeCharge80OutcomeValue,
  StripeCharge80,
  StripeCharge81BillingDetails,
  StripeCharge81OutcomeValue,
  StripeCharge81,
  StripeCharge82BillingDetails,
  StripeCharge82OutcomeValue,
  StripeCharge82,
  StripeCharge83BillingDetails,
  StripeCharge83OutcomeValue,
  StripeCharge83,
  StripeCharge84BillingDetails,
  StripeCharge84OutcomeValue,
  StripeCharge84,
  StripeCharge85BillingDetails,
  StripeCharge85OutcomeValue,
  StripeCharge85,
  StripeCharge86BillingDetails,
  StripeCharge86OutcomeValue,
  StripeCharge86,
  StripeCharge87BillingDetails,
  StripeCharge87OutcomeValue,
  StripeCharge87,
  StripeCharge88BillingDetails,
  StripeCharge88OutcomeValue,
  StripeCharge88,
  StripeCharge89BillingDetails,
  StripeCharge89OutcomeValue,
  StripeCharge89,
  StripeCharge90BillingDetails,
  StripeCharge90OutcomeValue,
  StripeCharge90,
  StripeCharge91BillingDetails,
  StripeCharge91OutcomeValue,
  StripeCharge91,
  StripeCharge92BillingDetails,
  StripeCharge92OutcomeValue,
  StripeCharge92,
  StripeCharge93BillingDetails,
  StripeCharge93OutcomeValue,
  StripeCharge93,
  StripeCharge94BillingDetails,
  StripeCharge94OutcomeValue,
  StripeCharge94,
  StripeCharge95BillingDetails,
  StripeCharge95OutcomeValue,
  StripeCharge95,
  StripeCharge96BillingDetails,
  StripeCharge96OutcomeValue,
  StripeCharge96,
  StripeCharge97BillingDetails,
  StripeCharge97OutcomeValue,
  StripeCharge97,
  StripeCharge98BillingDetails,
  StripeCharge98OutcomeValue,
  StripeCharge98,
  StripeCharge99BillingDetails,
  StripeCharge99OutcomeValue,
  StripeCharge99
}