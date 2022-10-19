# class BuyerPortalController
class BuyerPortalController < ApplicationController
  before_action :check_buyer

  def index
    @buyer = current_user
  end

  private

  def check_buyer
    if user_signed_in?
      return if current_user.user_type == 'Buyer'

      responder('You are not a Buyer.')
    else
      responder('Sign in to Access Portal.')
    end
  end

  def responder(message)
    respond_to do |format|
      format.html { redirect_to plans_url, notice: message }
      format.json { head :no_content }
    end
  end
end
