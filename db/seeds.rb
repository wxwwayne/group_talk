# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#users
(1..10).each do |n|
  User.create!(name: "TestAccount#{n}",
               email: "test#{n}@account.com",
               password: "password",
               password_confirmation: "password"
               )
end

#groups
20.times do |n|
  title = Faker::Hacker.adjective
  description = Faker::Hacker.say_something_smart
  Group.create!(title: title,
                description: description,
                user_id: rand(1...10))
end

#posts
users = User.order(:created_at).take(10)
10.times do
  content = Faker::Lorem.sentence(4)
  users.each { |user| user.posts.create!(content: content,
                                         group_id: rand(1...20))}
end
