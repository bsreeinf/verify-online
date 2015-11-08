class StudentVerificationController < ApplicationController
	before_action :logged_in_user, only: [:index, :status, :history ]
	
	def index
		@colleges = College.all
		if(params.has_key?(:college_id))
        	@college_id = params[:college_id]
        end
		render "apply"
	end

	def status
		@verifications = VerificationRequest.all.page params[:page]
		
	end

	def history

		@payments = Payment.all.page params[:page]
		
	end

end
