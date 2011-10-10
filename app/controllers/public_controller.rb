class PublicController < ApplicationController
  before_filter 'authenticate_user!'

  def index
    @days = CheckIn.get_month_checkins(current_user.id)
    @user = current_user
    @tasks = Task.find_all_by_user_id(current_user.id)
  end

  def show
    @days = CheckIn.get_month_checkins(current_user.id,params[:id].to_i)
    @user = current_user
    @tasks = Task.find_all_by_user_id(current_user.id)
  end

  def mobile
    render :layout => 'mobile'
    @days = CheckIn.get_past_check_ins(current_user.id, 8)
    @check_in = CheckIn.new

  end
  def homepage

  end
end
