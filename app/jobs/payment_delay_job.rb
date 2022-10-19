class PaymentDelayJob < ApplicationJob
  queue_as :default

  def perform(subscription, user)
    subscription.update(payment: false)
    UserMailer.payment_request(user, subscription).deliver_now
  end
end
