class CollegeVerificationController < ApplicationController
	 before_action :set_college_id


  def index
  	
  	@college_verifications =  VerificationRequest.all.where("college_id == ? AND verification_status_id = ?", @college_id, 1).paginate(page: params[:page],:per_page => 10)
  end


  def completed
  	
  	@college_verifications_completed =  VerificationRequest.all.where("college_id == ? AND verification_status_id != ?", @college_id,1).paginate(page: params[:page],:per_page => 10)
  end

  def payment
    @college_verifications =  VerificationRequest.all.where("college_id == ?", @college_id)
    @payments = Payment.all.where
  end

  def update
    

    # if params[:swiftinfo][:password].blank?
    #    params[:swiftinfo].delete(:password)
    # end

        @verification_request = VerificationRequest.find(params[:id])
        if @verification_request.update_attributes(update_params)
          flash[:success] = "Profile updated"
          redirect_to view_verifications_path
        else
           flash[:success] = "fuck off"
          redirect_to view_verifications_path
        end 
     
    
       
        
  end


  private

    def set_college_id
      @college_id = current_user.college.id      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.permit(:course, :type_of_studies,:course_duration, :class_awarded, :remarks,:verification_status_id)
    end

end
