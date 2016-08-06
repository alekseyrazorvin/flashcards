require 'spec_helper'


describe Card do

  before(:all) do
    @card = create(:card)
  end

  describe 'validation' do

    it 'dont create card without original_text' do
      @card.original_text = ''
      expect(@card).not_to be_valid
    end

    it 'dont create card without translated_text' do
      @card.translated_text = ''
      expect(@card).not_to be_valid
    end

    it 'dont create card if original_text equals translated_text' do
      @card.translated_text = @card.original_text
      expect(@card).not_to be_valid
    end

  end

  describe 'review_date' do

    it 'card create save with today date' do
      expect(@card.review_date).to eq(Time.now.to_date)
    end

  end

  describe 'random card' do

    it 'random card equals card' do
      expect(Card.random).to eq(@card)
    end

  end


end
