module ApplicationHelper
  def get_account_links()
    if current_user
      '<a href="/logout">Logout</a>'.html_safe
    else
      '<a href="/login">Login</a><a href="/signup">Sign Up</a>'.html_safe
    end
  end
end
