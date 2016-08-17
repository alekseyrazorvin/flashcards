FactoryGirl.define do

  factory :user do
    email "vasia@ya.ru"
    password "1234"
    password_confirmation { password }
  end

end