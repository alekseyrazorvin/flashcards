class OauthsController < ApplicationController
  skip_before_action :require_login
  before_action :require_login, only: :destroy

  def oauth
    login_at(auth_params[:provider])
  end


  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to @user, :notice => "Logged in from #{provider.titleize}! Начинайте тренировку."
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end


  private


  def auth_params
    params.permit(:code, :provider)
  end
end


