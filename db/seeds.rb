# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do |n|
	admin_user_id = 1
	name = Faker::Company.name
	address = Faker::Address.street_address
	College.create!(admin_user_id: admin_user_id, name: name, address: address)
end

30.times do |n|
	hallticket_no = Faker::Lorem.characters(10)	
	Student.create!(hallticket_no: hallticket_no)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')