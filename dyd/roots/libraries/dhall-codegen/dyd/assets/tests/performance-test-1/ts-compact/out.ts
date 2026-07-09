


export type StripeAddress = { city ?: string; country ?: string; line1 ?: string; line2 ?: string; postal_code ?: string; state ?: string; };


export type StripeCharge0BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge0OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge0 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge0BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge0OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge1BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge1OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge1 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge1BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge1OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge2BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge2OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge2 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge2BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge2OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge3BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge3OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge3 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge3BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge3OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge4BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge4OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge4 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge4BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge4OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge5BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge5OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge5 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge5BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge5OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge6BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge6OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge6 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge6BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge6OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge7BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge7OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge7 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge7BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge7OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge8BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge8OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge8 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge8BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge8OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge9BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge9OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge9 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge9BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge9OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge10BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge10OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge10 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge10BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge10OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge11BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge11OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge11 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge11BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge11OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge12BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge12OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge12 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge12BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge12OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge13BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge13OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge13 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge13BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge13OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge14BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge14OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge14 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge14BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge14OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge15BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge15OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge15 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge15BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge15OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge16BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge16OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge16 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge16BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge16OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge17BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge17OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge17 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge17BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge17OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge18BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge18OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge18 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge18BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge18OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge19BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge19OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge19 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge19BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge19OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge20BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge20OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge20 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge20BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge20OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge21BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge21OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge21 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge21BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge21OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge22BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge22OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge22 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge22BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge22OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge23BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge23OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge23 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge23BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge23OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge24BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge24OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge24 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge24BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge24OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge25BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge25OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge25 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge25BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge25OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge26BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge26OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge26 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge26BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge26OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge27BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge27OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge27 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge27BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge27OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge28BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge28OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge28 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge28BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge28OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge29BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge29OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge29 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge29BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge29OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge30BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge30OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge30 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge30BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge30OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge31BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge31OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge31 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge31BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge31OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge32BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge32OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge32 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge32BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge32OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge33BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge33OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge33 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge33BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge33OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge34BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge34OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge34 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge34BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge34OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge35BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge35OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge35 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge35BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge35OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge36BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge36OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge36 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge36BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge36OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge37BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge37OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge37 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge37BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge37OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge38BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge38OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge38 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge38BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge38OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge39BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge39OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge39 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge39BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge39OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge40BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge40OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge40 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge40BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge40OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge41BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge41OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge41 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge41BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge41OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge42BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge42OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge42 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge42BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge42OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge43BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge43OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge43 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge43BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge43OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge44BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge44OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge44 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge44BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge44OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge45BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge45OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge45 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge45BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge45OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge46BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge46OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge46 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge46BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge46OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge47BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge47OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge47 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge47BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge47OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge48BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge48OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge48 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge48BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge48OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge49BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge49OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge49 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge49BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge49OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge50BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge50OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge50 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge50BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge50OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge51BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge51OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge51 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge51BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge51OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge52BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge52OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge52 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge52BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge52OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge53BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge53OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge53 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge53BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge53OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge54BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge54OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge54 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge54BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge54OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge55BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge55OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge55 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge55BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge55OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge56BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge56OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge56 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge56BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge56OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge57BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge57OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge57 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge57BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge57OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge58BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge58OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge58 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge58BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge58OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge59BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge59OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge59 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge59BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge59OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge60BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge60OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge60 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge60BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge60OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge61BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge61OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge61 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge61BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge61OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge62BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge62OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge62 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge62BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge62OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge63BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge63OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge63 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge63BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge63OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge64BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge64OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge64 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge64BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge64OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge65BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge65OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge65 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge65BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge65OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge66BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge66OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge66 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge66BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge66OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge67BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge67OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge67 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge67BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge67OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge68BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge68OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge68 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge68BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge68OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge69BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge69OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge69 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge69BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge69OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge70BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge70OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge70 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge70BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge70OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge71BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge71OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge71 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge71BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge71OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge72BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge72OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge72 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge72BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge72OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge73BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge73OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge73 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge73BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge73OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge74BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge74OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge74 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge74BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge74OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge75BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge75OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge75 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge75BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge75OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge76BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge76OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge76 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge76BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge76OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge77BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge77OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge77 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge77BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge77OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge78BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge78OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge78 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge78BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge78OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge79BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge79OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge79 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge79BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge79OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge80BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge80OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge80 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge80BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge80OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge81BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge81OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge81 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge81BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge81OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge82BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge82OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge82 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge82BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge82OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge83BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge83OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge83 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge83BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge83OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge84BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge84OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge84 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge84BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge84OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge85BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge85OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge85 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge85BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge85OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge86BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge86OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge86 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge86BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge86OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge87BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge87OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge87 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge87BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge87OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge88BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge88OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge88 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge88BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge88OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge89BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge89OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge89 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge89BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge89OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge90BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge90OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge90 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge90BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge90OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge91BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge91OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge91 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge91BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge91OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge92BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge92OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge92 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge92BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge92OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge93BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge93OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge93 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge93BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge93OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge94BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge94OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge94 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge94BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge94OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge95BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge95OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge95 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge95BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge95OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge96BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge96OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge96 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge96BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge96OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge97BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge97OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge97 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge97BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge97OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge98BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge98OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge98 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge98BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge98OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };


export type StripeCharge99BillingDetails = { address ?: StripeAddress; email ?: /** email address */ string; name ?: /** customer name */ string; phone ?: string; };


export type StripeCharge99OutcomeValue = { type : string; advice_code ?: string; network_advice_code ?: string; network_decline_code ?: string; network_status ?: string; reason ?: string; risk_level ?: string; risk_score ?: number; rule ?: string; seller_message ?: string; };


export type StripeCharge99 = { amount : number; amount_captured : number; amount_refunded : number; billing_details : StripeCharge99BillingDetails; captured : boolean; created : /** Time at which the object was created. Measured in seconds since the Unix epoch. */ number; id : string; object : /** must be string 'charge' */ string; currency ?: string; outcome ?: StripeCharge99OutcomeValue; refunds ?: ( Array< string > | Array< StripeRefund > ); };
