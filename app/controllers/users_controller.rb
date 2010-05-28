class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user  = User.new(params[:user])
    if @user.save
      flash[:message] = "User successfully created"
      redirect_to user_path(@user.login)
    else
      flash[:error] = "User not created"
      render :new
    end
  end

  def show
    @user = User.find_by_login params[:login]
    @projects = Project.find_all_by_user_id @user.id
  end

end
