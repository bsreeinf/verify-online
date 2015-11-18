class LandingPageController < ApplicationController
 	before_action :set_colleges, only:[:index,:search_page]


  def index
  
  end
  def search_page
  	
  end


  private

  def set_colleges
  	@all_colleges = College.all
  end
end
