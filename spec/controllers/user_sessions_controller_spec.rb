require 'spec_helper'

describe UserSessionsController do
  fixtures :users

  def mock_session
    @mock_session ||= mock_model(UserSession)
  end

  def valid_attributes(attributes={})
    {
      :login => "viviane",
      :password => "minhasenha",
    }.merge attributes
  end

  context "GET new" do
    before :each do
      UserSession.stub!(:new).and_return(mock_session)
      get :new
    end

    it "should assign to @user_session a new instance" do
      assigns[:user_session].should == mock_session
    end
  end

  context "POST create" do
    it "should create a new session given valid attributes" do
      post :create, :user_session => valid_attributes
      user_session = UserSession.find
      user_session.should_not be_nil
      user = user_session.user
      user.should == users(:viviane)
      flash[:message].should == "Successfully logged in!"
      response.should redirect_to(root_url)
    end

    it "should not create a new session given invalid attributes" do
      post :create, :user_session => valid_attributes(:login => "joaomm")
      user_session = UserSession.find
      user_session.should be_nil
      flash[:message].should == "Invalid login or password!"
      response.should render_template(:new)
    end
  end

  context "DELETE destroy" do
    it "should destroy the current session" do
      post :create, :user_session => valid_attributes
      delete :destroy
      (UserSession.find).should be_nil
      flash[:message].should == 'Logged Out'
      response.should redirect_to(root_url)
    end
  end
end