class VerificationRequest < ActiveRecord::Base

	has_one :verification_status

	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    all 
	  end
	end

end
