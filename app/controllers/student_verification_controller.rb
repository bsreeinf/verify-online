class StudentVerificationController < ApplicationController
	before_action :logged_in_user, only: [:index, :status, :history ]
	
	def index
		render "apply"
	end

	def status
		render "status"
	end

	def history
		render "history"
	end

end
