

import { z } from 'zod';



export const StripeAddress = z.object({ city : z.string().optional(), country : z.string().optional(), line1 : z.string().optional(), line2 : z.string().optional(), postal_code : z.string().optional(), state : z.string().optional(), });
export type TStripeAddress = z.infer<typeof StripeAddress>


export const StripeCharge0BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge0BillingDetails = z.infer<typeof StripeCharge0BillingDetails>


export const StripeCharge0OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge0OutcomeValue = z.infer<typeof StripeCharge0OutcomeValue>


export const StripeCharge0 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge0BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge0OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge0 = z.infer<typeof StripeCharge0>


export const StripeCharge1BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge1BillingDetails = z.infer<typeof StripeCharge1BillingDetails>


export const StripeCharge1OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge1OutcomeValue = z.infer<typeof StripeCharge1OutcomeValue>


export const StripeCharge1 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge1BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge1OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge1 = z.infer<typeof StripeCharge1>


export const StripeCharge2BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge2BillingDetails = z.infer<typeof StripeCharge2BillingDetails>


export const StripeCharge2OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge2OutcomeValue = z.infer<typeof StripeCharge2OutcomeValue>


export const StripeCharge2 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge2BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge2OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge2 = z.infer<typeof StripeCharge2>


export const StripeCharge3BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge3BillingDetails = z.infer<typeof StripeCharge3BillingDetails>


export const StripeCharge3OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge3OutcomeValue = z.infer<typeof StripeCharge3OutcomeValue>


export const StripeCharge3 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge3BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge3OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge3 = z.infer<typeof StripeCharge3>


export const StripeCharge4BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge4BillingDetails = z.infer<typeof StripeCharge4BillingDetails>


export const StripeCharge4OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge4OutcomeValue = z.infer<typeof StripeCharge4OutcomeValue>


export const StripeCharge4 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge4BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge4OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge4 = z.infer<typeof StripeCharge4>


export const StripeCharge5BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge5BillingDetails = z.infer<typeof StripeCharge5BillingDetails>


export const StripeCharge5OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge5OutcomeValue = z.infer<typeof StripeCharge5OutcomeValue>


export const StripeCharge5 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge5BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge5OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge5 = z.infer<typeof StripeCharge5>


export const StripeCharge6BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge6BillingDetails = z.infer<typeof StripeCharge6BillingDetails>


export const StripeCharge6OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge6OutcomeValue = z.infer<typeof StripeCharge6OutcomeValue>


export const StripeCharge6 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge6BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge6OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge6 = z.infer<typeof StripeCharge6>


export const StripeCharge7BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge7BillingDetails = z.infer<typeof StripeCharge7BillingDetails>


export const StripeCharge7OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge7OutcomeValue = z.infer<typeof StripeCharge7OutcomeValue>


export const StripeCharge7 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge7BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge7OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge7 = z.infer<typeof StripeCharge7>


export const StripeCharge8BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge8BillingDetails = z.infer<typeof StripeCharge8BillingDetails>


export const StripeCharge8OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge8OutcomeValue = z.infer<typeof StripeCharge8OutcomeValue>


export const StripeCharge8 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge8BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge8OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge8 = z.infer<typeof StripeCharge8>


export const StripeCharge9BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge9BillingDetails = z.infer<typeof StripeCharge9BillingDetails>


export const StripeCharge9OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge9OutcomeValue = z.infer<typeof StripeCharge9OutcomeValue>


export const StripeCharge9 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge9BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge9OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge9 = z.infer<typeof StripeCharge9>


export const StripeCharge10BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge10BillingDetails = z.infer<typeof StripeCharge10BillingDetails>


export const StripeCharge10OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge10OutcomeValue = z.infer<typeof StripeCharge10OutcomeValue>


export const StripeCharge10 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge10BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge10OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge10 = z.infer<typeof StripeCharge10>


export const StripeCharge11BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge11BillingDetails = z.infer<typeof StripeCharge11BillingDetails>


export const StripeCharge11OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge11OutcomeValue = z.infer<typeof StripeCharge11OutcomeValue>


export const StripeCharge11 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge11BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge11OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge11 = z.infer<typeof StripeCharge11>


export const StripeCharge12BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge12BillingDetails = z.infer<typeof StripeCharge12BillingDetails>


export const StripeCharge12OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge12OutcomeValue = z.infer<typeof StripeCharge12OutcomeValue>


export const StripeCharge12 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge12BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge12OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge12 = z.infer<typeof StripeCharge12>


export const StripeCharge13BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge13BillingDetails = z.infer<typeof StripeCharge13BillingDetails>


export const StripeCharge13OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge13OutcomeValue = z.infer<typeof StripeCharge13OutcomeValue>


export const StripeCharge13 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge13BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge13OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge13 = z.infer<typeof StripeCharge13>


export const StripeCharge14BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge14BillingDetails = z.infer<typeof StripeCharge14BillingDetails>


export const StripeCharge14OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge14OutcomeValue = z.infer<typeof StripeCharge14OutcomeValue>


export const StripeCharge14 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge14BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge14OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge14 = z.infer<typeof StripeCharge14>


export const StripeCharge15BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge15BillingDetails = z.infer<typeof StripeCharge15BillingDetails>


export const StripeCharge15OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge15OutcomeValue = z.infer<typeof StripeCharge15OutcomeValue>


export const StripeCharge15 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge15BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge15OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge15 = z.infer<typeof StripeCharge15>


export const StripeCharge16BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge16BillingDetails = z.infer<typeof StripeCharge16BillingDetails>


export const StripeCharge16OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge16OutcomeValue = z.infer<typeof StripeCharge16OutcomeValue>


export const StripeCharge16 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge16BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge16OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge16 = z.infer<typeof StripeCharge16>


export const StripeCharge17BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge17BillingDetails = z.infer<typeof StripeCharge17BillingDetails>


export const StripeCharge17OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge17OutcomeValue = z.infer<typeof StripeCharge17OutcomeValue>


export const StripeCharge17 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge17BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge17OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge17 = z.infer<typeof StripeCharge17>


export const StripeCharge18BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge18BillingDetails = z.infer<typeof StripeCharge18BillingDetails>


export const StripeCharge18OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge18OutcomeValue = z.infer<typeof StripeCharge18OutcomeValue>


export const StripeCharge18 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge18BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge18OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge18 = z.infer<typeof StripeCharge18>


export const StripeCharge19BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge19BillingDetails = z.infer<typeof StripeCharge19BillingDetails>


export const StripeCharge19OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge19OutcomeValue = z.infer<typeof StripeCharge19OutcomeValue>


export const StripeCharge19 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge19BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge19OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge19 = z.infer<typeof StripeCharge19>


export const StripeCharge20BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge20BillingDetails = z.infer<typeof StripeCharge20BillingDetails>


export const StripeCharge20OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge20OutcomeValue = z.infer<typeof StripeCharge20OutcomeValue>


export const StripeCharge20 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge20BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge20OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge20 = z.infer<typeof StripeCharge20>


export const StripeCharge21BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge21BillingDetails = z.infer<typeof StripeCharge21BillingDetails>


export const StripeCharge21OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge21OutcomeValue = z.infer<typeof StripeCharge21OutcomeValue>


export const StripeCharge21 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge21BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge21OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge21 = z.infer<typeof StripeCharge21>


export const StripeCharge22BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge22BillingDetails = z.infer<typeof StripeCharge22BillingDetails>


export const StripeCharge22OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge22OutcomeValue = z.infer<typeof StripeCharge22OutcomeValue>


export const StripeCharge22 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge22BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge22OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge22 = z.infer<typeof StripeCharge22>


export const StripeCharge23BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge23BillingDetails = z.infer<typeof StripeCharge23BillingDetails>


export const StripeCharge23OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge23OutcomeValue = z.infer<typeof StripeCharge23OutcomeValue>


export const StripeCharge23 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge23BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge23OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge23 = z.infer<typeof StripeCharge23>


export const StripeCharge24BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge24BillingDetails = z.infer<typeof StripeCharge24BillingDetails>


export const StripeCharge24OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge24OutcomeValue = z.infer<typeof StripeCharge24OutcomeValue>


export const StripeCharge24 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge24BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge24OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge24 = z.infer<typeof StripeCharge24>


export const StripeCharge25BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge25BillingDetails = z.infer<typeof StripeCharge25BillingDetails>


export const StripeCharge25OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge25OutcomeValue = z.infer<typeof StripeCharge25OutcomeValue>


export const StripeCharge25 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge25BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge25OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge25 = z.infer<typeof StripeCharge25>


export const StripeCharge26BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge26BillingDetails = z.infer<typeof StripeCharge26BillingDetails>


export const StripeCharge26OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge26OutcomeValue = z.infer<typeof StripeCharge26OutcomeValue>


export const StripeCharge26 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge26BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge26OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge26 = z.infer<typeof StripeCharge26>


export const StripeCharge27BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge27BillingDetails = z.infer<typeof StripeCharge27BillingDetails>


export const StripeCharge27OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge27OutcomeValue = z.infer<typeof StripeCharge27OutcomeValue>


export const StripeCharge27 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge27BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge27OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge27 = z.infer<typeof StripeCharge27>


export const StripeCharge28BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge28BillingDetails = z.infer<typeof StripeCharge28BillingDetails>


export const StripeCharge28OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge28OutcomeValue = z.infer<typeof StripeCharge28OutcomeValue>


export const StripeCharge28 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge28BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge28OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge28 = z.infer<typeof StripeCharge28>


export const StripeCharge29BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge29BillingDetails = z.infer<typeof StripeCharge29BillingDetails>


export const StripeCharge29OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge29OutcomeValue = z.infer<typeof StripeCharge29OutcomeValue>


export const StripeCharge29 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge29BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge29OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge29 = z.infer<typeof StripeCharge29>


export const StripeCharge30BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge30BillingDetails = z.infer<typeof StripeCharge30BillingDetails>


export const StripeCharge30OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge30OutcomeValue = z.infer<typeof StripeCharge30OutcomeValue>


export const StripeCharge30 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge30BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge30OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge30 = z.infer<typeof StripeCharge30>


export const StripeCharge31BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge31BillingDetails = z.infer<typeof StripeCharge31BillingDetails>


export const StripeCharge31OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge31OutcomeValue = z.infer<typeof StripeCharge31OutcomeValue>


export const StripeCharge31 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge31BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge31OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge31 = z.infer<typeof StripeCharge31>


export const StripeCharge32BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge32BillingDetails = z.infer<typeof StripeCharge32BillingDetails>


export const StripeCharge32OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge32OutcomeValue = z.infer<typeof StripeCharge32OutcomeValue>


export const StripeCharge32 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge32BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge32OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge32 = z.infer<typeof StripeCharge32>


export const StripeCharge33BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge33BillingDetails = z.infer<typeof StripeCharge33BillingDetails>


export const StripeCharge33OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge33OutcomeValue = z.infer<typeof StripeCharge33OutcomeValue>


export const StripeCharge33 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge33BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge33OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge33 = z.infer<typeof StripeCharge33>


export const StripeCharge34BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge34BillingDetails = z.infer<typeof StripeCharge34BillingDetails>


export const StripeCharge34OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge34OutcomeValue = z.infer<typeof StripeCharge34OutcomeValue>


export const StripeCharge34 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge34BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge34OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge34 = z.infer<typeof StripeCharge34>


export const StripeCharge35BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge35BillingDetails = z.infer<typeof StripeCharge35BillingDetails>


export const StripeCharge35OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge35OutcomeValue = z.infer<typeof StripeCharge35OutcomeValue>


export const StripeCharge35 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge35BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge35OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge35 = z.infer<typeof StripeCharge35>


export const StripeCharge36BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge36BillingDetails = z.infer<typeof StripeCharge36BillingDetails>


export const StripeCharge36OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge36OutcomeValue = z.infer<typeof StripeCharge36OutcomeValue>


export const StripeCharge36 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge36BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge36OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge36 = z.infer<typeof StripeCharge36>


export const StripeCharge37BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge37BillingDetails = z.infer<typeof StripeCharge37BillingDetails>


export const StripeCharge37OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge37OutcomeValue = z.infer<typeof StripeCharge37OutcomeValue>


export const StripeCharge37 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge37BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge37OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge37 = z.infer<typeof StripeCharge37>


export const StripeCharge38BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge38BillingDetails = z.infer<typeof StripeCharge38BillingDetails>


export const StripeCharge38OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge38OutcomeValue = z.infer<typeof StripeCharge38OutcomeValue>


export const StripeCharge38 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge38BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge38OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge38 = z.infer<typeof StripeCharge38>


export const StripeCharge39BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge39BillingDetails = z.infer<typeof StripeCharge39BillingDetails>


export const StripeCharge39OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge39OutcomeValue = z.infer<typeof StripeCharge39OutcomeValue>


export const StripeCharge39 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge39BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge39OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge39 = z.infer<typeof StripeCharge39>


export const StripeCharge40BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge40BillingDetails = z.infer<typeof StripeCharge40BillingDetails>


export const StripeCharge40OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge40OutcomeValue = z.infer<typeof StripeCharge40OutcomeValue>


export const StripeCharge40 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge40BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge40OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge40 = z.infer<typeof StripeCharge40>


export const StripeCharge41BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge41BillingDetails = z.infer<typeof StripeCharge41BillingDetails>


export const StripeCharge41OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge41OutcomeValue = z.infer<typeof StripeCharge41OutcomeValue>


export const StripeCharge41 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge41BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge41OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge41 = z.infer<typeof StripeCharge41>


export const StripeCharge42BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge42BillingDetails = z.infer<typeof StripeCharge42BillingDetails>


export const StripeCharge42OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge42OutcomeValue = z.infer<typeof StripeCharge42OutcomeValue>


export const StripeCharge42 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge42BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge42OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge42 = z.infer<typeof StripeCharge42>


export const StripeCharge43BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge43BillingDetails = z.infer<typeof StripeCharge43BillingDetails>


export const StripeCharge43OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge43OutcomeValue = z.infer<typeof StripeCharge43OutcomeValue>


export const StripeCharge43 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge43BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge43OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge43 = z.infer<typeof StripeCharge43>


export const StripeCharge44BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge44BillingDetails = z.infer<typeof StripeCharge44BillingDetails>


export const StripeCharge44OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge44OutcomeValue = z.infer<typeof StripeCharge44OutcomeValue>


export const StripeCharge44 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge44BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge44OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge44 = z.infer<typeof StripeCharge44>


export const StripeCharge45BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge45BillingDetails = z.infer<typeof StripeCharge45BillingDetails>


export const StripeCharge45OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge45OutcomeValue = z.infer<typeof StripeCharge45OutcomeValue>


export const StripeCharge45 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge45BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge45OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge45 = z.infer<typeof StripeCharge45>


export const StripeCharge46BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge46BillingDetails = z.infer<typeof StripeCharge46BillingDetails>


export const StripeCharge46OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge46OutcomeValue = z.infer<typeof StripeCharge46OutcomeValue>


export const StripeCharge46 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge46BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge46OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge46 = z.infer<typeof StripeCharge46>


export const StripeCharge47BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge47BillingDetails = z.infer<typeof StripeCharge47BillingDetails>


export const StripeCharge47OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge47OutcomeValue = z.infer<typeof StripeCharge47OutcomeValue>


export const StripeCharge47 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge47BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge47OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge47 = z.infer<typeof StripeCharge47>


export const StripeCharge48BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge48BillingDetails = z.infer<typeof StripeCharge48BillingDetails>


export const StripeCharge48OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge48OutcomeValue = z.infer<typeof StripeCharge48OutcomeValue>


export const StripeCharge48 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge48BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge48OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge48 = z.infer<typeof StripeCharge48>


export const StripeCharge49BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge49BillingDetails = z.infer<typeof StripeCharge49BillingDetails>


export const StripeCharge49OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge49OutcomeValue = z.infer<typeof StripeCharge49OutcomeValue>


export const StripeCharge49 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge49BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge49OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge49 = z.infer<typeof StripeCharge49>


export const StripeCharge50BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge50BillingDetails = z.infer<typeof StripeCharge50BillingDetails>


export const StripeCharge50OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge50OutcomeValue = z.infer<typeof StripeCharge50OutcomeValue>


export const StripeCharge50 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge50BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge50OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge50 = z.infer<typeof StripeCharge50>


export const StripeCharge51BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge51BillingDetails = z.infer<typeof StripeCharge51BillingDetails>


export const StripeCharge51OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge51OutcomeValue = z.infer<typeof StripeCharge51OutcomeValue>


export const StripeCharge51 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge51BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge51OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge51 = z.infer<typeof StripeCharge51>


export const StripeCharge52BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge52BillingDetails = z.infer<typeof StripeCharge52BillingDetails>


export const StripeCharge52OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge52OutcomeValue = z.infer<typeof StripeCharge52OutcomeValue>


export const StripeCharge52 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge52BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge52OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge52 = z.infer<typeof StripeCharge52>


export const StripeCharge53BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge53BillingDetails = z.infer<typeof StripeCharge53BillingDetails>


export const StripeCharge53OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge53OutcomeValue = z.infer<typeof StripeCharge53OutcomeValue>


export const StripeCharge53 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge53BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge53OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge53 = z.infer<typeof StripeCharge53>


export const StripeCharge54BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge54BillingDetails = z.infer<typeof StripeCharge54BillingDetails>


export const StripeCharge54OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge54OutcomeValue = z.infer<typeof StripeCharge54OutcomeValue>


export const StripeCharge54 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge54BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge54OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge54 = z.infer<typeof StripeCharge54>


export const StripeCharge55BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge55BillingDetails = z.infer<typeof StripeCharge55BillingDetails>


export const StripeCharge55OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge55OutcomeValue = z.infer<typeof StripeCharge55OutcomeValue>


export const StripeCharge55 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge55BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge55OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge55 = z.infer<typeof StripeCharge55>


export const StripeCharge56BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge56BillingDetails = z.infer<typeof StripeCharge56BillingDetails>


export const StripeCharge56OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge56OutcomeValue = z.infer<typeof StripeCharge56OutcomeValue>


export const StripeCharge56 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge56BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge56OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge56 = z.infer<typeof StripeCharge56>


export const StripeCharge57BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge57BillingDetails = z.infer<typeof StripeCharge57BillingDetails>


export const StripeCharge57OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge57OutcomeValue = z.infer<typeof StripeCharge57OutcomeValue>


export const StripeCharge57 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge57BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge57OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge57 = z.infer<typeof StripeCharge57>


export const StripeCharge58BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge58BillingDetails = z.infer<typeof StripeCharge58BillingDetails>


export const StripeCharge58OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge58OutcomeValue = z.infer<typeof StripeCharge58OutcomeValue>


export const StripeCharge58 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge58BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge58OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge58 = z.infer<typeof StripeCharge58>


export const StripeCharge59BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge59BillingDetails = z.infer<typeof StripeCharge59BillingDetails>


export const StripeCharge59OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge59OutcomeValue = z.infer<typeof StripeCharge59OutcomeValue>


export const StripeCharge59 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge59BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge59OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge59 = z.infer<typeof StripeCharge59>


export const StripeCharge60BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge60BillingDetails = z.infer<typeof StripeCharge60BillingDetails>


export const StripeCharge60OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge60OutcomeValue = z.infer<typeof StripeCharge60OutcomeValue>


export const StripeCharge60 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge60BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge60OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge60 = z.infer<typeof StripeCharge60>


export const StripeCharge61BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge61BillingDetails = z.infer<typeof StripeCharge61BillingDetails>


export const StripeCharge61OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge61OutcomeValue = z.infer<typeof StripeCharge61OutcomeValue>


export const StripeCharge61 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge61BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge61OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge61 = z.infer<typeof StripeCharge61>


export const StripeCharge62BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge62BillingDetails = z.infer<typeof StripeCharge62BillingDetails>


export const StripeCharge62OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge62OutcomeValue = z.infer<typeof StripeCharge62OutcomeValue>


export const StripeCharge62 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge62BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge62OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge62 = z.infer<typeof StripeCharge62>


export const StripeCharge63BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge63BillingDetails = z.infer<typeof StripeCharge63BillingDetails>


export const StripeCharge63OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge63OutcomeValue = z.infer<typeof StripeCharge63OutcomeValue>


export const StripeCharge63 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge63BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge63OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge63 = z.infer<typeof StripeCharge63>


export const StripeCharge64BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge64BillingDetails = z.infer<typeof StripeCharge64BillingDetails>


export const StripeCharge64OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge64OutcomeValue = z.infer<typeof StripeCharge64OutcomeValue>


export const StripeCharge64 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge64BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge64OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge64 = z.infer<typeof StripeCharge64>


export const StripeCharge65BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge65BillingDetails = z.infer<typeof StripeCharge65BillingDetails>


export const StripeCharge65OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge65OutcomeValue = z.infer<typeof StripeCharge65OutcomeValue>


export const StripeCharge65 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge65BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge65OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge65 = z.infer<typeof StripeCharge65>


export const StripeCharge66BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge66BillingDetails = z.infer<typeof StripeCharge66BillingDetails>


export const StripeCharge66OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge66OutcomeValue = z.infer<typeof StripeCharge66OutcomeValue>


export const StripeCharge66 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge66BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge66OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge66 = z.infer<typeof StripeCharge66>


export const StripeCharge67BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge67BillingDetails = z.infer<typeof StripeCharge67BillingDetails>


export const StripeCharge67OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge67OutcomeValue = z.infer<typeof StripeCharge67OutcomeValue>


export const StripeCharge67 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge67BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge67OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge67 = z.infer<typeof StripeCharge67>


export const StripeCharge68BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge68BillingDetails = z.infer<typeof StripeCharge68BillingDetails>


export const StripeCharge68OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge68OutcomeValue = z.infer<typeof StripeCharge68OutcomeValue>


export const StripeCharge68 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge68BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge68OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge68 = z.infer<typeof StripeCharge68>


export const StripeCharge69BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge69BillingDetails = z.infer<typeof StripeCharge69BillingDetails>


export const StripeCharge69OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge69OutcomeValue = z.infer<typeof StripeCharge69OutcomeValue>


export const StripeCharge69 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge69BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge69OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge69 = z.infer<typeof StripeCharge69>


export const StripeCharge70BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge70BillingDetails = z.infer<typeof StripeCharge70BillingDetails>


export const StripeCharge70OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge70OutcomeValue = z.infer<typeof StripeCharge70OutcomeValue>


export const StripeCharge70 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge70BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge70OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge70 = z.infer<typeof StripeCharge70>


export const StripeCharge71BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge71BillingDetails = z.infer<typeof StripeCharge71BillingDetails>


export const StripeCharge71OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge71OutcomeValue = z.infer<typeof StripeCharge71OutcomeValue>


export const StripeCharge71 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge71BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge71OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge71 = z.infer<typeof StripeCharge71>


export const StripeCharge72BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge72BillingDetails = z.infer<typeof StripeCharge72BillingDetails>


export const StripeCharge72OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge72OutcomeValue = z.infer<typeof StripeCharge72OutcomeValue>


export const StripeCharge72 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge72BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge72OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge72 = z.infer<typeof StripeCharge72>


export const StripeCharge73BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge73BillingDetails = z.infer<typeof StripeCharge73BillingDetails>


export const StripeCharge73OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge73OutcomeValue = z.infer<typeof StripeCharge73OutcomeValue>


export const StripeCharge73 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge73BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge73OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge73 = z.infer<typeof StripeCharge73>


export const StripeCharge74BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge74BillingDetails = z.infer<typeof StripeCharge74BillingDetails>


export const StripeCharge74OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge74OutcomeValue = z.infer<typeof StripeCharge74OutcomeValue>


export const StripeCharge74 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge74BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge74OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge74 = z.infer<typeof StripeCharge74>


export const StripeCharge75BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge75BillingDetails = z.infer<typeof StripeCharge75BillingDetails>


export const StripeCharge75OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge75OutcomeValue = z.infer<typeof StripeCharge75OutcomeValue>


export const StripeCharge75 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge75BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge75OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge75 = z.infer<typeof StripeCharge75>


export const StripeCharge76BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge76BillingDetails = z.infer<typeof StripeCharge76BillingDetails>


export const StripeCharge76OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge76OutcomeValue = z.infer<typeof StripeCharge76OutcomeValue>


export const StripeCharge76 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge76BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge76OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge76 = z.infer<typeof StripeCharge76>


export const StripeCharge77BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge77BillingDetails = z.infer<typeof StripeCharge77BillingDetails>


export const StripeCharge77OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge77OutcomeValue = z.infer<typeof StripeCharge77OutcomeValue>


export const StripeCharge77 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge77BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge77OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge77 = z.infer<typeof StripeCharge77>


export const StripeCharge78BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge78BillingDetails = z.infer<typeof StripeCharge78BillingDetails>


export const StripeCharge78OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge78OutcomeValue = z.infer<typeof StripeCharge78OutcomeValue>


export const StripeCharge78 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge78BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge78OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge78 = z.infer<typeof StripeCharge78>


export const StripeCharge79BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge79BillingDetails = z.infer<typeof StripeCharge79BillingDetails>


export const StripeCharge79OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge79OutcomeValue = z.infer<typeof StripeCharge79OutcomeValue>


export const StripeCharge79 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge79BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge79OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge79 = z.infer<typeof StripeCharge79>


export const StripeCharge80BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge80BillingDetails = z.infer<typeof StripeCharge80BillingDetails>


export const StripeCharge80OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge80OutcomeValue = z.infer<typeof StripeCharge80OutcomeValue>


export const StripeCharge80 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge80BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge80OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge80 = z.infer<typeof StripeCharge80>


export const StripeCharge81BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge81BillingDetails = z.infer<typeof StripeCharge81BillingDetails>


export const StripeCharge81OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge81OutcomeValue = z.infer<typeof StripeCharge81OutcomeValue>


export const StripeCharge81 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge81BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge81OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge81 = z.infer<typeof StripeCharge81>


export const StripeCharge82BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge82BillingDetails = z.infer<typeof StripeCharge82BillingDetails>


export const StripeCharge82OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge82OutcomeValue = z.infer<typeof StripeCharge82OutcomeValue>


export const StripeCharge82 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge82BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge82OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge82 = z.infer<typeof StripeCharge82>


export const StripeCharge83BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge83BillingDetails = z.infer<typeof StripeCharge83BillingDetails>


export const StripeCharge83OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge83OutcomeValue = z.infer<typeof StripeCharge83OutcomeValue>


export const StripeCharge83 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge83BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge83OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge83 = z.infer<typeof StripeCharge83>


export const StripeCharge84BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge84BillingDetails = z.infer<typeof StripeCharge84BillingDetails>


export const StripeCharge84OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge84OutcomeValue = z.infer<typeof StripeCharge84OutcomeValue>


export const StripeCharge84 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge84BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge84OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge84 = z.infer<typeof StripeCharge84>


export const StripeCharge85BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge85BillingDetails = z.infer<typeof StripeCharge85BillingDetails>


export const StripeCharge85OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge85OutcomeValue = z.infer<typeof StripeCharge85OutcomeValue>


export const StripeCharge85 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge85BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge85OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge85 = z.infer<typeof StripeCharge85>


export const StripeCharge86BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge86BillingDetails = z.infer<typeof StripeCharge86BillingDetails>


export const StripeCharge86OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge86OutcomeValue = z.infer<typeof StripeCharge86OutcomeValue>


export const StripeCharge86 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge86BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge86OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge86 = z.infer<typeof StripeCharge86>


export const StripeCharge87BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge87BillingDetails = z.infer<typeof StripeCharge87BillingDetails>


export const StripeCharge87OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge87OutcomeValue = z.infer<typeof StripeCharge87OutcomeValue>


export const StripeCharge87 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge87BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge87OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge87 = z.infer<typeof StripeCharge87>


export const StripeCharge88BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge88BillingDetails = z.infer<typeof StripeCharge88BillingDetails>


export const StripeCharge88OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge88OutcomeValue = z.infer<typeof StripeCharge88OutcomeValue>


export const StripeCharge88 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge88BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge88OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge88 = z.infer<typeof StripeCharge88>


export const StripeCharge89BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge89BillingDetails = z.infer<typeof StripeCharge89BillingDetails>


export const StripeCharge89OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge89OutcomeValue = z.infer<typeof StripeCharge89OutcomeValue>


export const StripeCharge89 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge89BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge89OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge89 = z.infer<typeof StripeCharge89>


export const StripeCharge90BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge90BillingDetails = z.infer<typeof StripeCharge90BillingDetails>


export const StripeCharge90OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge90OutcomeValue = z.infer<typeof StripeCharge90OutcomeValue>


export const StripeCharge90 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge90BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge90OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge90 = z.infer<typeof StripeCharge90>


export const StripeCharge91BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge91BillingDetails = z.infer<typeof StripeCharge91BillingDetails>


export const StripeCharge91OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge91OutcomeValue = z.infer<typeof StripeCharge91OutcomeValue>


export const StripeCharge91 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge91BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge91OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge91 = z.infer<typeof StripeCharge91>


export const StripeCharge92BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge92BillingDetails = z.infer<typeof StripeCharge92BillingDetails>


export const StripeCharge92OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge92OutcomeValue = z.infer<typeof StripeCharge92OutcomeValue>


export const StripeCharge92 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge92BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge92OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge92 = z.infer<typeof StripeCharge92>


export const StripeCharge93BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge93BillingDetails = z.infer<typeof StripeCharge93BillingDetails>


export const StripeCharge93OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge93OutcomeValue = z.infer<typeof StripeCharge93OutcomeValue>


export const StripeCharge93 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge93BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge93OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge93 = z.infer<typeof StripeCharge93>


export const StripeCharge94BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge94BillingDetails = z.infer<typeof StripeCharge94BillingDetails>


export const StripeCharge94OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge94OutcomeValue = z.infer<typeof StripeCharge94OutcomeValue>


export const StripeCharge94 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge94BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge94OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge94 = z.infer<typeof StripeCharge94>


export const StripeCharge95BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge95BillingDetails = z.infer<typeof StripeCharge95BillingDetails>


export const StripeCharge95OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge95OutcomeValue = z.infer<typeof StripeCharge95OutcomeValue>


export const StripeCharge95 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge95BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge95OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge95 = z.infer<typeof StripeCharge95>


export const StripeCharge96BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge96BillingDetails = z.infer<typeof StripeCharge96BillingDetails>


export const StripeCharge96OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge96OutcomeValue = z.infer<typeof StripeCharge96OutcomeValue>


export const StripeCharge96 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge96BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge96OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge96 = z.infer<typeof StripeCharge96>


export const StripeCharge97BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge97BillingDetails = z.infer<typeof StripeCharge97BillingDetails>


export const StripeCharge97OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge97OutcomeValue = z.infer<typeof StripeCharge97OutcomeValue>


export const StripeCharge97 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge97BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge97OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge97 = z.infer<typeof StripeCharge97>


export const StripeCharge98BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge98BillingDetails = z.infer<typeof StripeCharge98BillingDetails>


export const StripeCharge98OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge98OutcomeValue = z.infer<typeof StripeCharge98OutcomeValue>


export const StripeCharge98 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge98BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge98OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge98 = z.infer<typeof StripeCharge98>


export const StripeCharge99BillingDetails = z.object({ address : StripeAddress.optional(), email : z.string().describe("email address").optional(), name : z.string().describe("customer name").optional(), phone : z.string().optional(), });
export type TStripeCharge99BillingDetails = z.infer<typeof StripeCharge99BillingDetails>


export const StripeCharge99OutcomeValue = z.object({ type : z.string(), advice_code : z.string().optional(), network_advice_code : z.string().optional(), network_decline_code : z.string().optional(), network_status : z.string().optional(), reason : z.string().optional(), risk_level : z.string().optional(), risk_score : z.number().int().optional(), rule : z.string().optional(), seller_message : z.string().optional(), });
export type TStripeCharge99OutcomeValue = z.infer<typeof StripeCharge99OutcomeValue>


export const StripeCharge99 = z.object({ amount : z.number().int(), amount_captured : z.number().int(), amount_refunded : z.number().int(), billing_details : StripeCharge99BillingDetails, captured : z.boolean(), created : z.number().int().describe("Time at which the object was created. Measured in seconds since the Unix epoch."), id : z.string(), object : z.string().describe("must be string 'charge'"), currency : z.string().optional(), outcome : StripeCharge99OutcomeValue.optional(), refunds : z.union([ z.array( z.string() ), z.array( StripeRefund ) ]).optional(), });
export type TStripeCharge99 = z.infer<typeof StripeCharge99>
