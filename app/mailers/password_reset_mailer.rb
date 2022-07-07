class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]

    mail to: @user.email, subject: I18n.t("password_resets.new.reset_email.subject")
  end
end