class VerificationStatus < ActiveRecord::Base

	has_many :verification_request
end
