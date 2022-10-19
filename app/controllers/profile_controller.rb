# class ProfileController
class ProfileController < ApplicationController
  before_action :check_user

  def index
    @user = current_user
  end

  private

  def check_user
    return if user_signed_in?

    redirect_to '/'
  end
end
