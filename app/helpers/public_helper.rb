module PublicHelper
  def convert_to_check(item)
    if item
      return 'checked'
    else
      return 'unchecked'
    end

  end

  def get_month_name(monthnum = Date.current.mon)
    Date::MONTHNAMES[monthnum].to_s
  end

  def get_prev_month_url(monthnum = Date.current.mon)
    prev_month = monthnum - 1
    '/month/'+prev_month.to_s
  end
  def get_next_month_url(monthnum = Date.current.mon)
    prev_month = monthnum + 1
    '/month/'+prev_month.to_s
  end
end
