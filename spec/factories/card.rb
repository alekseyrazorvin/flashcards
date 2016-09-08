FactoryGirl.define do

  factory :card do
    original_text "Паук"
    translated_text "Spider"
    user
    picture { File.new("#{Rails.root}/spec/fixtures/images/image.jpg")  }
    deck
  end

end


