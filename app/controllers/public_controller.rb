class PublicController < ApplicationController
  
  def index
    @days = CheckIn.all
  end

  def mobile
    render :layout => 'mobile'
    @days = CheckIn.all
  end

end
