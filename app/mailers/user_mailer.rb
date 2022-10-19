# class UserMailer
class UserMailer < ApplicationMailer
  def check_mailer
    @greetings = 'hi'
    mail to: 'm.mogheesasif@gmail.com'
  end

  def new_account(user)
    @user = user
    @message = 'Congrats on creating your new account'
    mail to: @user.email
  end

  def payment_request(user, subscription)
    @sub = subscription
    @user = user
    @message = 'Please Pay your due payment of your subscription'
    mail to: @user.email, subject: 'Payment Due'
  end

  def contact_us(user_mail, message)
    @message = message
    @user_mail = user_mail
    mail to: @user_mail, subject: 'Hi Sir'
  end
end
