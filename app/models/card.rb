class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck

  has_attached_file :picture,
                    styles: { thumb: "360x3600>" },
                    default_url: "/images/:style/missing.png"

  scope :random, -> { where("review_date <= ?", Date.today).order('RANDOM()').first }
  scope :random_from_current_deck, ->(d) { where("review_date <= ? AND deck_id = ?", Date.today, d).order('RANDOM()').first }


  validates :original_text, :translated_text, :picture, :deck_id, presence: true
  validates_associated :user, :deck
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  
  validate :original_translated_text_are_different
  def original_translated_text_are_different
    if self.original_text == self.translated_text
      errors.add(:original_text, 'должен отличаться')
      errors.add(:translated_text, 'должен отличаться')
    end
  end

  def self.random_card
    self.where(["review_date <= ?", Date.today]).order('RANDOM()').first
  end

  before_save :set_review_date
  def set_review_date
    self.review_date = Date.today + PERIODS[number_of_correct]
  end

  def picture_from_url=(url_value)
    self.picture = URI.parse(url_value)
    @picture_from_url = url_value
  end

  PERIODS = [0, 0.5, 3, 7, 14, 30].freeze

  def correct_answer
    if number_of_correct <= 4
      update_columns(number_of_correct: number_of_correct + 1)
    end
    update_columns(number_of_incorrect: 0)
    set_review_date
    update_columns(review_date: review_date)
  end

  def incorrect_answer
    update_columns(number_of_incorrect: number_of_incorrect + 1)
    if number_of_incorrect == 3
      if number_of_correct > 0
        update_columns(number_of_correct: number_of_correct - 1)
        update_columns(number_of_incorrect: 0)
      end
    end
    set_review_date
    update_columns(review_date: review_date)
  end

end
