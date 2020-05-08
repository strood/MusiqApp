class UserMailer < ApplicationMailer
  # This file is created when i run the rails g mailer UserMailer command to first
  # setup mailer
  # In it I can set up functionality for my mailer.
  default from: 'admin@musiq.com'

# Wont send an email, will just set one up for me when called in user controller
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Musiq, your song info HQ.")
  end

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Musiq Account Activation")
  end

  # COuld also add reminder emails, ect.

end
