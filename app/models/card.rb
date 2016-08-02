class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  
  validate :original_translated_text_are_different
  def original_translated_text_are_different
    if self.original_text == self.translated_text
      errors.add(:original_text, 'должен отличаться')
      errors.add(:translated_text, 'должен отличаться')
    end
  end

  before_save :set_review_date
  before_update :set_review_date
  def set_review_date
    self.review_date = 3.days.from_now
  end

  scope :target_review_date, -> { where("review_date <= ?", Date.today) }
 
end
