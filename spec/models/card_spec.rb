require 'spec_helper'

describe Card do

  let(:user) { create :user }
  let(:card) { create(:card, user: user) }

  describe 'review_date' do
    it 'card create save with today date plus 3' do
      expect(card.review_date.strftime("%Y-%m-%d")).to eq(3.days.from_now.strftime("%Y-%m-%d"))
    end
  end

  describe 'random card' do
    it 'random card equals card' do
      card.update_columns(review_date: Date.today)
      expect(Card.random).to eq(card)
    end
  end

end
