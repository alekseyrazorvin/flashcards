include ActionDispatch::TestProcess
FactoryGirl.define do

  factory :card do
    original_text "Паук"
    translated_text "Spider"
    review_date Date.current
    number_of_correct 0
    number_of_incorrect 0
    user
    picture { fixture_file_upload(Rails.root.join("spec", "fixtures", "images", "spider.jpg"), "image.jpg") }
    #picture { File.new("#{Rails.root}/spec/fixtures/images/image.jpg")  } #for paperclip local storage
    deck
  end

end

#for local storage paperclip
#picture { File.new("#{Rails.root}/spec/fixtures/images/image.jpg")  }



