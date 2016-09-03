class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :check_answer]

  def index
    if current_user.current_deck_id
      @deck = current_user.decks.find(current_user.current_deck_id)
      @cards = @deck.cards.all
    else
      @cards = current_user.cards.all
    end

    unless @cards.first
      flash[:alert] = "Карточек нет. Создайте карточку"
      redirect_to new_card_url
    end
  end

  def show
  end

  def new
    @card = current_user.cards.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    @card.save
    redirect_to @card
  end
  
  def update
    @card.update(card_params)
    redirect_to @card
  end

  def destroy
    @card.destroy
    redirect_to cards_url
  end

  def train
    if current_user.current_deck_id
      @deck = current_user.decks.find(current_user.current_deck_id)
      @card = @deck.cards.random
    else
      @card = current_user.cards.random
    end


    if @card.present?
      render :train
    else
      redirect_to new_card_url
      flash[:alert] = "Карточек нет. Создайте карточку"
    end
  end

  def check_answer
    #render plain: card_params.inspect + params[:q].inspect + params[:card][:original_text].inspect

    if params[:q] == params[:card][:original_text]
      @card.update(card_params)
      redirect_to @card, notice: 'Отлично! Ты знаешь это слово. Повтори через 3 дня.'
    else
      redirect_to @card, alert: 'Это слово нужно повторить' 
    end
  end

  private
    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :picture, :deck_id)
    end
end
