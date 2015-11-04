FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    password "password"

    factory :update_user do
      current_password "password"
    end
  end
end
