class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :check_answer]
  
  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
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


  def show_random_card
    @card = Card.target_review_date.offset(rand(Card.target_review_date.count)).first
  end

  def check_answer
    #render plain: card_params.inspect + params[:q].inspect + params[:card][:original_text].inspect

    if params[:q] == params[:card][:original_text]
      @card.update(card_params)
      redirect_to card_url, notice: 'Отлично! Ты знаешь это слово. Повтори через 3 дня.'
    else
      redirect_to card_url, alert: 'Это слово нужно повторить' 
    end
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end
end
