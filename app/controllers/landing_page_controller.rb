class LandingPageController < ApplicationController
 
  def index
  	@all_colleges = College.all
  end

end
