class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :except => [:not_authenticated]


  private


  def not_authenticated
    redirect_to login_path, :alert => "Войдите в систему"
  end


end
