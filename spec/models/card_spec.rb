require 'spec_helper'


describe Card do

  let(:user) { create :user }
  let(:card) { create(:card, user: user) }

  describe 'review_date' do

    it 'card create save with today date' do
      expect(card.review_date).to eq(Time.now.to_date)
    end

  end

  describe 'random card' do

    it 'random card equals card' do
      expect(card).to eq(Card.random)
    end

  end

end
