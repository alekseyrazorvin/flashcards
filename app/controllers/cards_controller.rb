class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :check_answer]
  before_action :set_deck, only: [:index, :train]

  def index
    if current_user.current_deck_id
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
    @card.update_columns(review_date: params[:card][:review_date],
                          original_text: params[:card][:original_text],
                          translated_text: params[:card][:translated_text])
    redirect_to @card
  end

  def destroy
    @card.destroy
    redirect_to cards_url
  end

  def train
    if current_user.current_deck_id
      @card = @deck.cards.random_card
    else
      @card = current_user.cards.random_card
    end

    if @card
      render :train
    else
      # current_user.decks
      if current_user.cards.first
        flash[:alert] = "На сегодня карточки для тренировки закончились . Установите дату проверки слова вручную из списка ниже"
        redirect_to cards_url
      else
        redirect_to new_card_url
        flash[:alert] = "Карточек нет. Создайте карточку"
      end
    end
  end

  def check_answer
    #render plain: card_params.inspect + params[:q].inspect + params[:card][:original_text].inspect

    if params[:q] == params[:card][:original_text]
      @card.correct_answer
      flash[:notice] = 'Отлично! Ты знаешь это слово. Повторяй реже'
    else
      if @card.typo(params[:q]) <= 2
        @card.correct_answer
        flash[:alert] = @card.translated_text + ' переводится: ' +
                          @card.original_text +
                          ' , а напечтали с опечатками: ' + params[:q]
      else
        @card.incorrect_answer
        flash[:alert] = 'Это слово нужно повторять чаще'
      end
    end
    redirect_to @card
  end

  private
    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def set_deck
      @deck = current_user.decks.find(current_user.current_deck_id) if current_user.current_deck_id
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date, :picture, :deck_id, :user_id)
    end
end
