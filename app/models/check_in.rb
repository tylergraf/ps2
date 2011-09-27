class CheckIn < ActiveRecord::Base
  belongs_to :user
  #current_user = User.find(session[:user_id])
  def self.get_past_check_ins(user, resolution)
    start_date = Time.now + 1.day
    date_obj = create_checkin_obj(user, resolution, start_date)
    return date_obj.reverse
  end

  def self.get_month_checkins(user, monthnum = Date.current.mon)

    ###uses monthnum to get number of days in month###
    resolution = (Date.new(Time.now.year,12,31).to_date<<(12-monthnum)).day

    ###uses monthnum to get first day of the month###
    start_date = (Date.new(Time.now.year,12,31).to_date<<(12-monthnum)).at_beginning_of_month

    date_obj = create_checkin_obj(user, resolution, start_date)
    return date_obj
  end



  def self.create_checkin_obj(user,resolution, start_date)
    check_in_obj = []
    user_checkins = self.find_all_by_user_id(user)
    check_in_obj_ = []
    ticker = -1
    resolution.times do |i|
      check_in_temp = user_checkins[i]
      if check_in_temp
        check_in_obj << check_in_temp
      else
        check_in_obj << self.new
      end
    end
    resolution.times do |f|
      resolution.times do |a|
        if (check_in_obj[a].date.to_s == start_date.strftime("%Y-%m-%d"))
          check_in_obj_ << check_in_obj[a]
          ticker += 1
        end
        if a == resolution - 1 && check_in_obj[a].date.to_s != start_date.strftime("%Y-%m-%d") && ticker != f
            check_in_obj_ << self.new(:date => start_date.strftime("%Y-%m-%d"), :total => '&ndash;')
            ticker +=1
        end
      end
      start_date += 1.day
    end
    check_in_obj_

  end


end
