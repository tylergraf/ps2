class PublicController < ApplicationController
  before_filter 'authenticate_user!'

  def index
    render :layout => 'application'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
    @check_in = CheckIn.new
  end

  def month

    @days = CheckIn.get_month_checkins(current_user.id, Date.current.mon)
    @check_in = CheckIn.new
    @user = current_user
  end

  def mobile
    render :layout => 'mobile'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
    @check_in = CheckIn.new

  end

end
