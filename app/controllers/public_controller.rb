class PublicController < ApplicationController
  before_filter 'authenticate_user!'

  def index
    @days = CheckIn.get_month_checkins(current_user.id,1)
    @check_in = CheckIn.new
    @user = current_user
  end

  def show
    @days = CheckIn.get_month_checkins(current_user.id,params[:id].to_i)
    @check_in = CheckIn.new
    @user = current_user
  end

  def mobile
    render :layout => 'mobile'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
    @check_in = CheckIn.new

  end
  def homepage

  end
end
