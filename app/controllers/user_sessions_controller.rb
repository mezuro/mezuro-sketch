class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      flash[:message] = "Successfully logged in!"
      redirect_to user_path(@user_session.user.id)
    else
      flash[:message] = "Invalid login or password!"
      render :new
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:message] = "Logged Out"
    redirect_to root_url
  end
end
