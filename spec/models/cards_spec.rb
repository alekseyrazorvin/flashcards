require 'spec_helper'


describe Card do

  let(:user) { create :user }
  let(:card) { create(:card, user: user) }

  describe 'review_date' do

    it 'card create save with today date' do
      expect(card.review_date).to eq(Time.now.to_date)
    end

  end

  DatabaseCleaner.clean

  describe 'random card' do

    it 'random card equals card' do
      expect(Card.random.original_text).to eq(card.original_text)
    end

  end

end
