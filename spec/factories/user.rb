FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "vasia#{n}@ya.ru" }
    password "1234"
    password_confirmation { password }
  end

end