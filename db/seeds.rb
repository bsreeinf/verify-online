# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cuser=User.create!(
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
College.create!(
	user_id: cuser.id,
	name: "East Point College of engineering", 
	address: "Aavaada  Halli",
	verification_amount: 800)

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
VerificationStatus.create!(	description: "New"	)
VerificationStatus.create!(	description: "Pending"	)
VerificationStatus.create!(	description: "Matched"	)
VerificationStatus.create!(	description: "Unmatched")


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


30.times do |n|
	student_id = 2
	college_id = 1
	verification_status_id = 1
	name = name = FFaker::Name.name
	hallticket_no = FFaker::Lorem.characters(6)	
	document_link = "https://s3-ap-southeast-1.amazonaws.com/verifyonline-documents/uploads/dummy/wo.jpg"	
	amount = rand(500..2000)
	service_tax = amount * 0.05
	course = FFaker::Lorem.characters(5).upcase
	type_of_studies = 	FFaker::Lorem.characters(3).upcase





	VerificationRequest.create!(student_id: student_id,
		college_id: college_id,
		verification_status_id: verification_status_id,
		name: name,
		hallticket_no: hallticket_no,
		document_link: document_link,
		amount: amount,
		service_tax: service_tax,
		course: course,
		type_of_studies: type_of_studies
		)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

#Agustin O'Kon DDS
#buddy@thiel.co


#Romaguera LLC

