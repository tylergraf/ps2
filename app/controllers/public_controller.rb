class PublicController < ApplicationController
  
  def index
    #render :layout => 'mobile'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
    @check_in = CheckIn.new
  end

  def mobile
    #render :layout => 'mobile'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
  end

end
