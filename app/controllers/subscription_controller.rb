class SubscriptionController < ApplicationController
  before_action :check_user
  before_action :set_subscription, only: %i[add_usage destroy details]
  before_action :set_plan
  before_action :check_subscription, only: :subscribe

  def subscribe
    @subscribe = Subscription.new(plan_id: @plan.id, user_id: current_user.id, biling_date: 30.days.from_now)
    if @subscribe.save
      create_sub_features
      @subscribe.update(bill: @total_bill + @plan.monthly_fee)
      @subscribe.update(stripe_price_id: Stripe::Price.create({ unit_amount: @subscribe.bill * 100, currency: 'usd', recurring: { interval: 'month' }, product: @plan.stripe_plan_id }).id)
      @subscribe.update(stripe_id: Stripe::Subscription.create({ customer: current_user.stripe_id, items: [{ price: @subscribe.stripe_price_id }] }).id)
      responder('Sucessfully Subscribed.')
    else
      responder('Unsucessfull')
    end
  end

  def add_usage
    @current_feature = @subscription.sub_features.find(params[:feature])
    usage = @current_feature.current_usage + 1
    if usage > @current_feature.max_usage
      @current_feature.update(current_usage: usage, bill: usage * @current_feature.unit_price)
      bil = @subscription.bill
      @subscription.update(bill: bil + @current_feature.unit_price)
      @subscription.update(stripe_price_id: Stripe::Price.create({ unit_amount: @subscription.bill * 100, currency: 'usd', recurring: { interval: 'month' }, product: @plan.stripe_plan_id }).id)
    else
      @current_feature.update(current_usage: usage)
    end
    responder('Usage added sucessfully')
  end

  def destroy
    if @subscription.payment?
      @subscription.destroy
      responder('Unsubscribed Sucessfully')
    else
      responder('Pay the bill first')
    end
  end

  def details; end

  private

  def subscription_params
    params.require(:subscription).permit(:plan_id, :biling_date, :user_id, :bill, :payment, :stripe_id, :stripe_price_id)
  end

  def responder(message)
    respond_to do |format|
      format.html { redirect_to buyer_portal_index_path, notice: message }
      format.json { head :no_content }
    end
  end

  def check_user
    return if user_signed_in? && current_user.user_type == 'Buyer'

    responder('You need to sign in as a buyer in order to subscribe')
  end

  def check_subscription
    return unless current_user.subscriptions.find_by(plan_id: @plan.id)

    responder('Already subscribed.')
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription])
  end

  def create_sub_features
    @total_bill = 0
    @plan.features.each do |f|
      bil = f.max_limit * f.unit_price
      @total_bill += bil
      @subscribe.sub_features.create(name: f.name, unit_price: f.unit_price, max_usage: f.max_limit, bill: bil)
    end
  end
end
