class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user  = User.new(params[:user])
    if @user.save
      flash[:message] = "User successfully created"
      redirect_to user_path(@user.id)
    else
      flash[:message] = "User not created"
      render :new
    end
  end

  def show
    @user = User.find_by_id params[:id]
    @projects = Project.find_all_by_user_id @user.id
  end

end
