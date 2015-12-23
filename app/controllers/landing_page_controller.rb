class LandingPageController < ApplicationController
 	before_action :set_colleges, only:[:index,:search_page]


  def index
  
  end
  def search_page
  	
  end

  def verification_status
  	@status = VerificationRequest.where("verification_token ILIKE ?", params[:id])

  	respond_to do |format|
      format.json {render json: @status}
    end
  end


  private

  def set_colleges
  	@all_colleges = College.all
  end
end
