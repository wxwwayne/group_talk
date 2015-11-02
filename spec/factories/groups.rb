FactoryGirl.define do
  factory :group do
    title {Faker::Hacker.adjective}
    user
  end
end
