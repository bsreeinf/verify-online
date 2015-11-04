# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

15.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.email
	phone = Faker::PhoneNumber.cell_phone
	password = "password"
	
	User.create!(name:  name,
	             email: email,
	             phone: phone,
	             password:              password,
	             password_confirmation: password,
	             activated:    true,
	             activated_at: Time.zone.now)
end

30.times do |n|
	
	name = Faker::Company.name
	address = Faker::Address.street_address
	College.create!(name: name, address: address)
end

30.times do |n|
	hallticket_no = Faker::Lorem.characters(10)	
	Student.create!(hallticket_no: hallticket_no)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

#Agustin O'Kon DDS
#buddy@thiel.co


#Romaguera LLC

