# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      do_sign_in(user)
    else
      flash[:warning] = t('flash_messages.warning.sessions.incorrect_data')
      render :new
    end
  end

  def do_sign_in(user)
    sign_in user
    remember(user) if params[:remember_me] == '1'
    flash[:success] = t('flash_messages.success.sessions.signed_in') + ", #{current_user.name_or_email}!"
    redirect_to root_path
  end

  def destroy
    sign_out
    flash[:success] = t('flash_messages.success.sessions.signed_out')
    redirect_to root_path, status: :see_other
  end
end
