class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    UserMailer.contact_us(@contact.email, @contact.message).deliver_now

    # @contact.request = request
    # if @contact.deliver
    #   flash.now[:success] = 'Message sent!'
    # else
    #   flash.now[:error] = 'Could not send message'
    #   render :new
    # end
  end

  def request_account
    @contact = Contact.new
  end
end
