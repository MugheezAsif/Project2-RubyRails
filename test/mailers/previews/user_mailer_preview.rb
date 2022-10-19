# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def check_mailer 
        UserMailer.check_mailer
    end
    def new_account 
        UserMailer.new_account
    end
end
