FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"

    factory :update_user do
      current_password "password"
    end
  end
end
