class CheckIn < ActiveRecord::Base
  belongs_to :user

  def self.get_past_check_ins(user, resolution)
    the_date = Time.now + 1.day
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
        if (check_in_obj[a].date.to_s == the_date.strftime("%Y-%m-%d"))
          check_in_obj_ << check_in_obj[a]
          ticker += 1
        end
        if a == resolution - 1 && check_in_obj[a].date.to_s != the_date.strftime("%Y-%m-%d") && ticker != f
            check_in_obj_ << self.new(:date => the_date.strftime("%Y-%m-%d"), :total => '&ndash;')
            ticker +=1
        end
      end
      the_date -= 1.day
    end
    
    check_in_obj_

  end
end
