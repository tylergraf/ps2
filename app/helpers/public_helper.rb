module PublicHelper
  def convert_to_check(item)
    if item
      return 'checked'
    else
      return 'unchecked'
    end

  end
end
