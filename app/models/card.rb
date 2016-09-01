class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck

  has_attached_file :picture,
                    styles: { thumb: "360x3600>" },
                    default_url: "/images/:style/missing.png"

  scope :random, -> { where("review_date <= ?", Date.today).order('RANDOM()').first }

  validates :original_text, :translated_text, presence: true
  validates_associated :user, :deck
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  
  validate :original_translated_text_are_different
  def original_translated_text_are_different
    if self.original_text == self.translated_text
      errors.add(:original_text, 'должен отличаться')
      errors.add(:translated_text, 'должен отличаться')
    end
  end

  before_save :set_review_date
  def set_review_date
    self.review_date = Date.today
  end



  def picture_from_url=(url_value)
    self.picture = URI.parse(url_value)
    @picture_from_url = url_value
  end





end
