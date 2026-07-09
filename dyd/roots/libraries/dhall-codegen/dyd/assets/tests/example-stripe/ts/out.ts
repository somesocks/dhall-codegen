


export type StripeAddress =
	{
		city ?:
			string;
		country ?:
			string;
		line1 ?:
			string;
		line2 ?:
			string;
		postal_code ?:
			string;
		state ?:
			string;
	};


export type StripeCustomer =
	{
		balance :
			number;
		created :
			number;
		id :
			string;
		object :
			/** must be string 'customer' */
			string;
		address ?:
			StripeAddress;
		currency ?:
			string;
		description ?:
			string;
		email ?:
			/** email address */
			string;
		name ?:
			/** customer name */
			string;
	};


export type StripeChargeBillingDetails =
	{
		address ?:
			StripeAddress;
		email ?:
			/** email address */
			string;
		name ?:
			/** customer name */
			string;
		phone ?:
			string;
	};


export type StripeChargeOutcomeValue =
	{
		type :
			string;
		advice_code ?:
			string;
		network_advice_code ?:
			string;
		network_decline_code ?:
			string;
		network_status ?:
			string;
		reason ?:
			string;
		risk_level ?:
			string;
		risk_score ?:
			number;
		rule ?:
			string;
		seller_message ?:
			string;
	};


export type StripeCharge =
	{
		amount :
			number;
		amount_captured :
			number;
		amount_refunded :
			number;
		billing_details :
			StripeChargeBillingDetails;
		captured :
			boolean;
		created :
			/** Time at which the object was created. Measured in seconds since the Unix epoch. */
			number;
		id :
			string;
		object :
			/** must be string 'charge' */
			string;
		currency ?:
			string;
		outcome ?:
			StripeChargeOutcomeValue;
		refunds ?:
			(
				Array<
					string
				> |
				Array<
					StripeRefund
				>
			);
	};


export type StripeRefund =
	{
		amount :
			number;
		charge :
			(
				string |
				StripeCharge
			);
		id :
			string;
		object :
			/** must be string 'refund' */
			string;
	};
