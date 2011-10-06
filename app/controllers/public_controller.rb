class PublicController < ApplicationController
  before_filter 'authenticate_user!'

  def index
    @days = CheckIn.get_month_checkins(current_user.id)
    @check_in = CheckIn.new
    @user = current_user
    @tasks = Task.find_all_by_user_id(current_user.id)
    #@stuff = CheckIn.joins(:tasks).where("user_id <= ?", current_user.id)
    #@stuff = CheckIn.joins(:tasks).where("check_ins.user_id = ?",current_user.id).limit(1)
    #@stuff = CheckIn.find_by_sql("SELECT * FROM `check_ins` INNER JOIN `check_ins_tasks` ON `check_ins_tasks`.`check_in_id` = `check_ins`.`id` INNER JOIN `tasks` ON `tasks`.`id` = `check_ins_tasks`.`task_id` WHERE (check_ins.user_id = 1) LIMIT 1")
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
