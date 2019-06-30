class WelcomeMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/"
    mail(to: @user.email, subject: "Welcome to Fakebook!")
  end
end
