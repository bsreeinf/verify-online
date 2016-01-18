class Payment < ActiveRecord::Base
	belongs_to :verification_request
end