class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  def index
    @decks = current_user.decks.all
  end


  def show
  end

  def new
    @deck = current_user.decks.new
  end

  def edit
  end


  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to @deck
      flash[:notice] = 'Колода создана'
    else
      render :new
    end
  end

  def update
    if current_user.decks.update(deck_params)
      redirect_to @deck
      flash[:notice] = 'Колода обновлена'
    else
      render :edit
    end
  end


  def destroy
    @deck.destroy
    redirect_to decks_url
    flash[:notice] = 'Колода карт удалена'

  end

  def set_current
    current_user.update(current_deck_id: params[:id])
    redirect_to decks_path
  end

  def reset_current
    current_user.update(current_deck_id: nil)
    redirect_to decks_path
  end

  private
    def set_deck
      @deck = current_user.decks.find(params[:id])
    end

    def deck_params
      params.require(:deck).permit(:title, :user_id)
    end
end
