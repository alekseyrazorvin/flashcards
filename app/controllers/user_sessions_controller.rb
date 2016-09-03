class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to(@user, notice: 'Вы в системе. Начните тренировку')
    else
      flash.now[:alert] = 'Неправильные данные. Попробуйте еще раз.'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_url, notice: 'Вышли из системы! Ждем снова.')
  end
end
