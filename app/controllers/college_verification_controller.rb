class CollegeVerificationController < ApplicationController
	
  def index
  	@college_id = current_user.college.id
  	@college_verifications =  VerificationRequest.all.where("college_id == ? AND verification_status_id = ?", @college_id, 1).paginate(page: params[:page],:per_page => 10)
  end


  def completed
  	@college_id = current_user.college.id
  	@college_verifications =  VerificationRequest.all.where("college_id == ?", @college_id)
  end

  def payment
  end

end
