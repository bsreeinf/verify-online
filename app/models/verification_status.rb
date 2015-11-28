class VerificationStatus < ActiveRecord::Base

	has_many :verification_requests
end
