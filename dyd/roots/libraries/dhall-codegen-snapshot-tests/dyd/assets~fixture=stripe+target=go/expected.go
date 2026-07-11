package models


type StripeAddress struct {
	City *string `json:"city,omitempty"`
	Country *string `json:"country,omitempty"`
	Line1 *string `json:"line1,omitempty"`
	Line2 *string `json:"line2,omitempty"`
	PostalCode *string `json:"postal_code,omitempty"`
	State *string `json:"state,omitempty"`
}

type StripeCustomer struct {
	Balance int `json:"balance"`
	Created int `json:"created"`
	Id string `json:"id"`
	Object string `json:"object"`
	Address *StripeAddress `json:"address,omitempty"`
	Currency *string `json:"currency,omitempty"`
	Description *string `json:"description,omitempty"`
	Email *string `json:"email,omitempty"`
	Name *string `json:"name,omitempty"`
}

type StripeChargeBillingDetails struct {
	Address *StripeAddress `json:"address,omitempty"`
	Email *string `json:"email,omitempty"`
	Name *string `json:"name,omitempty"`
	Phone *string `json:"phone,omitempty"`
}

type StripeChargeOutcomeValue struct {
	Type string `json:"type"`
	AdviceCode *string `json:"advice_code,omitempty"`
	NetworkAdviceCode *string `json:"network_advice_code,omitempty"`
	NetworkDeclineCode *string `json:"network_decline_code,omitempty"`
	NetworkStatus *string `json:"network_status,omitempty"`
	Reason *string `json:"reason,omitempty"`
	RiskLevel *string `json:"risk_level,omitempty"`
	RiskScore *int `json:"risk_score,omitempty"`
	Rule *string `json:"rule,omitempty"`
	SellerMessage *string `json:"seller_message,omitempty"`
}

type StripeChargeRefundsValueKind string

const (
	StripeChargeRefundsValueKindOption1 StripeChargeRefundsValueKind = "option1"
	StripeChargeRefundsValueKindOption2 StripeChargeRefundsValueKind = "option2"
)

type StripeChargeRefundsValue struct {
	Kind StripeChargeRefundsValueKind `json:"kind"`
	Option1 *[]string `json:"option1,omitempty"`
	Option2 *[]StripeRefund `json:"option2,omitempty"`
}

type StripeCharge struct {
	Amount int `json:"amount"`
	AmountCaptured int `json:"amount_captured"`
	AmountRefunded int `json:"amount_refunded"`
	BillingDetails StripeChargeBillingDetails `json:"billing_details"`
	Captured bool `json:"captured"`
	Created int `json:"created"`
	Id string `json:"id"`
	Object string `json:"object"`
	Currency *string `json:"currency,omitempty"`
	Outcome *StripeChargeOutcomeValue `json:"outcome,omitempty"`
	Refunds *StripeChargeRefundsValue `json:"refunds,omitempty"`
}

type StripeRefundChargeKind string

const (
	StripeRefundChargeKindOption1 StripeRefundChargeKind = "option1"
	StripeRefundChargeKindOption2 StripeRefundChargeKind = "option2"
)

type StripeRefundCharge struct {
	Kind StripeRefundChargeKind `json:"kind"`
	Option1 *string `json:"option1,omitempty"`
	Option2 *StripeCharge `json:"option2,omitempty"`
}

type StripeRefund struct {
	Amount int `json:"amount"`
	Charge StripeRefundCharge `json:"charge"`
	Id string `json:"id"`
	Object string `json:"object"`
}
