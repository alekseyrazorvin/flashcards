require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean



describe Card do

  before(:each) do
    user = create (:user)
    @card = create(:card, user: user)
  end



  describe 'review_date' do

    it 'card create save with today date' do
      expect(@card.review_date).to eq(Time.now.to_date)
    end

  end

  DatabaseCleaner.clean

  describe 'random card' do

    it 'random card equals card' do
      expect(Card.random).to eq(@card)
    end

  end

end
