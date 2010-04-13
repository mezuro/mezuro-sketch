class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user  = User.new(params[:user])
    if @user.save
      flash[:message] = "User successfully created"
      redirect_to(root_url)
    else
      flash[:message] = "User not created"
      render :new
    end
  end

end