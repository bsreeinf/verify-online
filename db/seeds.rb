# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
	name:  'sreenath',
	email: "sreenath@gmail.com",
	phone: 8553047951,
	address:   FFaker::Address.street_address,
	city: 	FFaker::Address.city ,
	pincode: 	560006,
	state: 	"Karnataka",
	country: 	"India",
	password:              "password",
	password_confirmation: "password",
	activated:    true,
	activated_at: Time.zone.now
	)


User.create!(
	name:  'allen',
	email: "allen@gmail.com",
	phone: 8553047951,
	address:   FFaker::Address.street_address,
	city: 	FFaker::Address.city ,
	pincode: 	560006,
	state: 	"Karnataka",
	country: 	"India",
	password:              "password",
	password_confirmation: "password",
	activated:    true,
	activated_at: Time.zone.now
	)



15.times do |n|
	name = FFaker::Name.name
	email = FFaker::Internet.safe_email
	phone = FFaker::PhoneNumber.short_phone_number
	address = FFaker::Address.street_address
	city = FFaker::Address.city 
	state = "Karnataka"
	password = "password"
	
	User.create!(name:  name,
	             email: email,
	             phone: phone,
	             address: address,
				 city: city,
				 pincode: 	560006,
				 state: 	"karnataka",
				 country: 	"India",
	             password:              password,
	             password_confirmation: password,
	             activated:    true,
	             activated_at: Time.zone.now)
end



30.times do |n|
	
	name = FFaker::Company.name
	address = FFaker::Address.street_address
	amount = rand(500..2000)
	College.create!(name: name, address: address,verification_amount: amount)
end

30.times do |n|
	hallticket_no = FFaker::Lorem.characters(10)	
	Student.create!(hallticket_no: hallticket_no)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

#Agustin O'Kon DDS
#buddy@thiel.co


#Romaguera LLC

