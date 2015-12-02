class CollegeVerificationController < ApplicationController
	 before_action :set_college_id
   layout 'application', :except => [:report]

  def index
  	
  	@college_verifications =  VerificationRequest.all.where("college_id = ? AND verification_status_id = ?", @college_id, 1).paginate(page: params[:page],:per_page => 10)
  end


  def completed
  	
  	@college_verifications_completed =  VerificationRequest.all.where("college_id = ? AND verification_status_id != ?", @college_id,1).paginate(page: params[:page],:per_page => 10)
  end

  def report
    @disable_header_footer = true
    @verification_stub = VerificationRequest.find_by(id: params[:verification_id])
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}", 
                template: "college_verification/report.html.erb"
      end
    end
  end

  def payment
    @college_verifications =  VerificationRequest.all.where("college_id = ?", @college_id)
    @payments = Payment.all.where
  end

  def update
    @verification_request = VerificationRequest.find(params[:id])
    if @verification_request.update_attributes(update_params)
      flash[:success] = "Verification Status updated"
      redirect_to view_verifications_path
    else
       flash[:success] = "Update failed"
      redirect_to view_verifications_path
    end 
  end


  private

    def set_college_id
      @college_id = current_user.college.id      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.permit(:course, :type_of_studies,:course_duration, :class_awarded, :remarks, :verification_status_id)
    end

end
