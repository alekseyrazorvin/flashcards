require 'spec_helper'

describe Card do

  let(:user) { create :user }
  let(:card) { create(:card, user: user) }

  describe 'review_date' do
    it 'when card create review_date is toady' do
      expect(card.review_date.strftime("%Y-%m-%d")).to eq(Date.today.strftime("%Y-%m-%d"))
    end
  end

  context 'correct_answer' do
    it 'number_of_correct increases 1' do
      card.correct_answer
      expect(card.number_of_correct).to eq(1)
    end

    it 'first correct answer review_date increases 0,5 day ' do
      card.correct_answer
      expect(card.review_date).to eq(Date.today + 0.5)
    end

    it 'second correct answer review_date increases 3 day ' do
      card.update_columns(number_of_correct: 1)
      card.correct_answer
      expect(card.review_date).to eq(Date.today + 3)
    end

    it 'fourth correct answer review_date increases 7 day ' do
      card.update_columns(number_of_correct: 2)
      card.correct_answer
      expect(card.review_date).to eq(Date.today + 7)
    end

    it 'fifth correct answer review_date increases 14 day ' do
      card.update_columns(number_of_correct: 3)
      card.correct_answer
      expect(card.review_date).to eq(Date.today + 14)
    end

    it 'sixth correct answer review_date increases 30 day ' do
      card.update_columns(number_of_correct: 4)
      card.correct_answer
      expect(card.review_date).to eq(Date.today + 30)
    end
  end

  context 'incorrect_answer' do
    it 'number_of_incorrect increases 1' do
      card.incorrect_answer
      expect(card.number_of_incorrect).to eq(1)
    end

    it 'when numbers_of_incorrect equal 3 numbers_of_correct decreases 1 or 0' do
      card.update_columns(number_of_incorrect: 2, number_of_correct: 1)
      card.incorrect_answer
      expect(card.number_of_correct).to eq(0)
      expect(card.number_of_incorrect).to eq(0)
    end
  end

  describe 'random card' do
    it 'random card equals card' do
      expect(card).to eq(Card.random)
    end
  end

end
