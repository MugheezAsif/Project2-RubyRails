class CheckoutController < ApplicationController
  after_action :set_job, only: [:create]

  def create
    @user = current_user
    @@subscription = Subscription.find(params[:subscription])
    @session = Stripe::Checkout::Session.create(
      customer: @user.stripe_id,
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [{ quantity: 1, price: @@subscription.stripe_price_id }]
    )
  end

  def success
    @plan = Plan.find(@@subscription.plan_id)
    @@subscription.update(bill: @plan.monthly_fee)
    @@subscription.update(payment: true)
    @@subscription.sub_features.each do |feature|
      feature.update(current_usage: 0, bill: feature.max_usage * feature.unit_price)
      @@subscription.update(bill: @@subscription.bill + feature.bill)
    end
    responder('Payment successfully paied.')
  end

  def cancel
    responder('Payment failed.')
  end

  private

  def set_job
    @user = User.find(@@subscription.user_id)
    PaymentDelayJob.set(wait: 1.minute).perform_later(@@subscription, @user)
  end

  def responder(message)
    respond_to do |format|
      format.html { redirect_to buyer_portal_index_url, notice: message }
      format.json { head :no_content }
    end
  end
end
