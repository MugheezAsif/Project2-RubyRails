class Contact < MailForm::Base
  validates :name, :email, :message, presence: true
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  validates :name, length: { maximum: 18 }
  validates :email, length: { maximum: 24 }
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'Contact Us',
      to: 'm.mogheesasif@gmail.com',
      from: %("#{name}" <#{email}>)
    }
  end
end
