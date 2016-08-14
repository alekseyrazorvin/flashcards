class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update]
  skip_before_action :require_login, only: [:new, :create]


  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:notice] = "Ты зарегался на нашем сервисе"
      flash[:success] = "Начинай тренировку"
      redirect_to root_url
    else
      render :new
    end
  end


  def update
      if @user.update(user_params)
        flash[:notice] = "Данные обновлены"
        redirect_to root_url
      else
        flash[:alert] = "Что-то не так. Обновите еще раз"
        render :edit
      end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
