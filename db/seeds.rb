# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create users

User.create!(first_name: "Example",
						 last_name: "User",
						 email: "example@railstutorial.org",
						 password: "foobar",
						 password_confirmation: "foobar",
						 admin: true)

99.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	email = "example-#{n+1}@gmail.com"
	password = "password"
	User.create!(first_name: first_name,
							 last_name: last_name,
							 email: email,
							 password: password,
							 password_confirmation: password)
end


# Create trips for the first 6 users

users = User.order(:created_at).take(6)
50.times do |n|
	name = "Trip #{n + 1}"
	description = Faker::Lorem.sentence(3)
	start_loc = Faker::Address.city
	end_loc = Faker::Address.city
	users.each { |user| user.trips.create!(name: name,
																				 description: description,
																				 start_loc: start_loc,
																				 end_loc: end_loc) }
end