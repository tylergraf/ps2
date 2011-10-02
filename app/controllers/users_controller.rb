class UsersController < ApplicationController
 
  def new
    @user = User.new

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      do_login(params[:user][:email],params[:user][:password])
    else
      render "new"
    end
  end


end
