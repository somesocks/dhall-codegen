let Grammar = ./dhall-codegen/grammar.dhall

let Document = Grammar.Document

let s = Grammar.Schema

let nameSchema =
      s.text.from
        s.text.props::{=}
        s.text.meta::{ description = Some "customer name" }

let emailSchema =
      s.text.from
        s.text.props::{=}
        s.text.meta::{ description = Some "email address" }

let addressSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { line1 =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , line2 =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , city =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , country =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , postal_code =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , state =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            }
        }
        s.record.meta::{=}

let addressSchema =
      s.root.from addressSchema s.root.meta::{ name = "StripeAddress" }

let addressReference =
      s.reference.from
        s.reference.props::{ to = addressSchema.meta.name }
        s.reference.meta::{=}

let customerSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { id = s.text.from s.text.props::{=} s.text.meta::{=}
            , object =
                s.text.from
                  s.text.props::{=}
                  s.text.meta::{
                  , description = Some "must be string 'customer'"
                  }
            , balance =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , created =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , currency =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , description =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , name =
                s.optional.from
                  s.optional.props::{ value = nameSchema }
                  s.optional.meta::{=}
            , email =
                s.optional.from
                  s.optional.props::{ value = emailSchema }
                  s.optional.meta::{=}
            , address =
                s.optional.from
                  s.optional.props::{ value = addressReference }
                  s.optional.meta::{=}
            }
        }
        s.record.meta::{=}

let customerSchema =
      s.root.from customerSchema s.root.meta::{ name = "StripeCustomer" }

let chargeOutcomeSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { advice_code =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , network_advice_code =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , network_decline_code =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , network_status =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , reason =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , risk_level =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , risk_score =
                s.optional.from
                  s.optional.props::{
                  , value =
                      s.number.from
                        s.number.props::{ variant = s.number.variants.integer }
                        s.number.meta::{=}
                  }
                  s.optional.meta::{=}
            , rule =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , seller_message =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , type = s.text.from s.text.props::{=} s.text.meta::{=}
            }
        }
        s.record.meta::{=}

let chargeRefundsSchema =
      s.oneOf.from
        s.oneOf.props::{
        , options =
          [ s.list.from
              s.list.props::{
              , values = s.text.from s.text.props::{=} s.text.meta::{=}
              }
              s.list.meta::{=}
          , s.list.from
              s.list.props::{
              , values =
                  s.reference.from
                    s.reference.props::{ to = "StripeRefund" }
                    s.reference.meta::{=}
              }
              s.list.meta::{=}
          ]
        }
        s.oneOf.meta::{=}

let chargeSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { id = s.text.from s.text.props::{=} s.text.meta::{=}
            , object =
                s.text.from
                  s.text.props::{=}
                  s.text.meta::{ description = Some "must be string 'charge'" }
            , amount =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , amount_captured =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , amount_refunded =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , billing_details =
                s.record.from
                  s.record.props::{
                  , required = toMap
                      { address =
                          s.optional.from
                            s.optional.props::{ value = addressReference }
                            s.optional.meta::{=}
                      , email =
                          s.optional.from
                            s.optional.props::{ value = emailSchema }
                            s.optional.meta::{=}
                      , name =
                          s.optional.from
                            s.optional.props::{ value = nameSchema }
                            s.optional.meta::{=}
                      , phone =
                          s.optional.from
                            s.optional.props::{
                            , value =
                                s.text.from s.text.props::{=} s.text.meta::{=}
                            }
                            s.optional.meta::{=}
                      }
                  }
                  s.record.meta::{=}
            , captured = s.boolean.from s.boolean.props::{=} s.boolean.meta::{=}
            , created =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{
                  , description = Some
                      "Time at which the object was created. Measured in seconds since the Unix epoch."
                  }
            , currency =
                s.optional.from
                  s.optional.props::{
                  , value = s.text.from s.text.props::{=} s.text.meta::{=}
                  }
                  s.optional.meta::{=}
            , outcome =
                s.optional.from
                  s.optional.props::{ value = chargeOutcomeSchema }
                  s.optional.meta::{=}
            , refunds =
                s.optional.from
                  s.optional.props::{ value = chargeRefundsSchema }
                  s.optional.meta::{=}
            }
        }
        s.record.meta::{=}

let chargeSchema =
      s.root.from chargeSchema s.root.meta::{ name = "StripeCharge" }

let refundSchema =
      s.record.from
        s.record.props::{
        , required = toMap
            { id = s.text.from s.text.props::{=} s.text.meta::{=}
            , object =
                s.text.from
                  s.text.props::{=}
                  s.text.meta::{ description = Some "must be string 'refund'" }
            , amount =
                s.number.from
                  s.number.props::{ variant = s.number.variants.integer }
                  s.number.meta::{=}
            , charge =
                s.oneOf.from
                  s.oneOf.props::{
                  , options =
                    [ s.text.from s.text.props::{=} s.text.meta::{=}
                    , s.reference.from
                        s.reference.props::{ to = chargeSchema.meta.name }
                        s.reference.meta::{=}
                    ]
                  }
                  s.oneOf.meta::{=}
            }
        }
        s.record.meta::{=}

let refundSchema =
      s.root.from refundSchema s.root.meta::{ name = "StripeRefund" }

let def =
      Document::{
      , schemas = [ addressSchema, customerSchema, chargeSchema, refundSchema ]
      }

in  def
