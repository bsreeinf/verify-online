class CollegeVerificationController < ApplicationController
	
  def index
  	@college_id = current_user.college.id
  	@college_verifications =  VerificationRequest.all.where("college_id == ?", @college_id)
  end


  def completed
  	@college_id = current_user.college.id
  	@college_verifications =  VerificationRequest.all.where("college_id == ?", @college_id)
  end

  def payment
  end

end
