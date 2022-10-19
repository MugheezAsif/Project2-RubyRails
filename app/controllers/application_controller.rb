# application controller
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_stripe_key

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_type email avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name user_type email avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email avatar])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[email name avatar user_type])
  end

  def set_stripe_key
    Stripe.api_key = 'sk_test_51LnQTfCQz7yg6my8gymXqlFIE2I5kiRyqTjbjHiikHth35D1BCVUM28ybTRs50HviQ74xvAAojhI7NHnn88TDQ1F00oBUZ3Iu3'
  end
end
