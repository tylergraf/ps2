class CheckIn < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tasks
  
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
    notes = Note.find_all_by_user_id(user)
    tasks = Task.find_all_by_user_id(user)
    check_in_obj = []
    user_checkins = self.find_by_sql("select c.id, c.date, t.task, c.done, t.task_frequency from check_ins c join check_ins_tasks ct on ct.check_in_id = c.id join tasks t on t.id = ct.task_id where c.user_id = "+user.to_s)
    resolution.times do |r|
      check_in_obj << self.new(:date => start_date.strftime("%Y-%m-%d"),:done => false)
      tasks.length.times do |t|
        check_in_obj[r]['checked_'+t.to_s] = false
      end
      check_in_obj[r]['notes'] = ''
      check_in_obj[r]['note_id'] = ''
      check_in_obj[r]['note_recorded'] = false
      start_date +=1.day
    end
    check_in_obj.length.times do |c|
      user_checkins.length.times do |u|
        if (user_checkins[u].date.to_s == check_in_obj[c].date.to_s)
          tasks.length.times do |t|
            if (user_checkins[u].task.to_s == tasks[t].task.to_s)
              if (user_checkins[u].done == true)
                check_in_obj[c]['checkin_'+t.to_s] = user_checkins[u].id
                check_in_obj[c]['checked_'+t.to_s] = true
              else
                check_in_obj[c]['checked_'+t.to_s] = false
                check_in_obj[c]['checkin_'+t.to_s] = user_checkins[u].id
              end
              check_in_obj[c]['recorded_'+t.to_s] = true
            end
          end
        end
        notes.length.times do |n|
          if (check_in_obj[c].date.to_s == notes[n].date.to_s)
            check_in_obj[c]['notes'] = notes[n].notes
            check_in_obj[c]['note_id'] = notes[n].id
            check_in_obj[c]['note_recorded'] = true
          end
        end
      end
    end
    return check_in_obj
  end


end
