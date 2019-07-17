class WelcomeMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = "fierce-atoll-88019.herokuapp.com"
    mail(to: @user.email, subject: "Welcome to Fakebook!")
  end
end
