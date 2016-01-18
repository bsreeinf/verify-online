class VerificationRequest < ActiveRecord::Base
	include Tokenable
	
	# belongs_to :student
	belongs_to :college
	belongs_to :verification_status
	has_one :payment

	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    all 
	  end
	end

end
