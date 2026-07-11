

import { z } from 'zod';



export const StripeAddress =
	z.object({
		city :
			z.string().optional(),
		country :
			z.string().optional(),
		line1 :
			z.string().optional(),
		line2 :
			z.string().optional(),
		postal_code :
			z.string().optional(),
		state :
			z.string().optional(),
	});
export type TStripeAddress = z.infer<typeof StripeAddress>


export const StripeCustomer =
	z.object({
		balance :
			z.number().int(),
		created :
			z.number().int(),
		id :
			z.string(),
		object :
			z.string().describe("must be string 'customer'"),
		address :
			StripeAddress.optional(),
		currency :
			z.string().optional(),
		description :
			z.string().optional(),
		email :
			z.string().describe("email address").optional(),
		name :
			z.string().describe("customer name").optional(),
	});
export type TStripeCustomer = z.infer<typeof StripeCustomer>


export const StripeChargeBillingDetails =
	z.object({
		address :
			StripeAddress.optional(),
		email :
			z.string().describe("email address").optional(),
		name :
			z.string().describe("customer name").optional(),
		phone :
			z.string().optional(),
	});
export type TStripeChargeBillingDetails = z.infer<typeof StripeChargeBillingDetails>


export const StripeChargeOutcomeValue =
	z.object({
		type :
			z.string(),
		advice_code :
			z.string().optional(),
		network_advice_code :
			z.string().optional(),
		network_decline_code :
			z.string().optional(),
		network_status :
			z.string().optional(),
		reason :
			z.string().optional(),
		risk_level :
			z.string().optional(),
		risk_score :
			z.number().int().optional(),
		rule :
			z.string().optional(),
		seller_message :
			z.string().optional(),
	});
export type TStripeChargeOutcomeValue = z.infer<typeof StripeChargeOutcomeValue>


export const StripeCharge =
	z.object({
		amount :
			z.number().int(),
		amount_captured :
			z.number().int(),
		amount_refunded :
			z.number().int(),
		billing_details :
			StripeChargeBillingDetails,
		captured :
			z.boolean(),
		created :
			z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."),
		id :
			z.string(),
		object :
			z.string().describe("must be string 'charge'"),
		currency :
			z.string().optional(),
		outcome :
			StripeChargeOutcomeValue.optional(),
		refunds :
			z.union([
				z.array(
					z.string()
				),
				z.array(
					StripeRefund
				)
			]).optional(),
	});
export type TStripeCharge = z.infer<typeof StripeCharge>


export const StripeRefund =
	z.object({
		amount :
			z.number().int(),
		charge :
			z.union([
				z.string(),
				StripeCharge
			]),
		id :
			z.string(),
		object :
			z.string().describe("must be string 'refund'"),
	});
export type TStripeRefund = z.infer<typeof StripeRefund>
