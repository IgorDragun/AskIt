class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by email: params[:email]

    if @user.present?
      @user.set_password_reset_token

      PasswordResetMailer.with(user: @user).reset_email.deliver_later
    end

    flash[:success] = t("flash_messages.success.reset_password.sent_message")
    redirect_to new_session_path
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t("flash_messages.success.reset_password.was_reset")
      redirect_to new_session_path
    else
      render :edit
    end
  end



  private

  def set_user
    @user = User.find_by email: params[:user][:email],
                         password_reset_token: params[:user][:password_reset_token]

    redirect_to(new_session_path,
                flash: { warning: t('.user_messages.fail') }) unless @user&.password_reset_period_valid?
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end
end