class SessionsController < ApplicationController

  def new
  end

  def create
    #@url = request.url
    #puts 'homosexual'+@url
    do_login(params[:email],params[:password])

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
