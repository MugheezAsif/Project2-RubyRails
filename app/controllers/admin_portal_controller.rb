# class AdminPortalController
class AdminPortalController < ApplicationController
  before_action :set_users
  before_action :check_admin

  def index; end

  def user_details
    @user = User.find(params[:user])
  end

  def payment_request
    @user = User.find(params[:user])
    @subscription = Subscription.find(params[:subscription])
    if UserMailer.payment_request(@user, @subscription).deliver_now
      responder('Email sent sucessfull.')
    else
      responder('Email could not be sent.')
    end
  end

  private

  def check_admin
    if user_signed_in?
      return if current_user.user_type == 'Admin'

      responder('You are not an Admin.')
    else
      responder('Sign in to Access Portal.')
    end
  end

  def responder(message)
    respond_to do |format|
      format.html { redirect_to admin_portal_index_url, notice: message }
      format.json { head :no_content }
    end
  end

  def set_users
    @admin = current_user
    @plans = Plan.all
    @users = User.all
  end
end
