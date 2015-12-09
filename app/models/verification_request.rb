class VerificationRequest < ActiveRecord::Base

	belongs_to :student
	belongs_to :college
	belongs_to :verification_status
	belongs_to :payment

	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    all 
	  end
	end

end
