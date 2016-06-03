Rails.configuration.stripe = {
  :publishable_key => 'pk_test_l8vHTycCHQtPxRGBPoisKZbh',
  :secret_key      => 'sk_test_ONIIeHZeEJozjTwqRKJElH30'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
