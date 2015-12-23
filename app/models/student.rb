class Student < ActiveRecord::Base
	has_many :verification_requests
	belongs_to :user

	def to_s
		# user.name 

	end
end
