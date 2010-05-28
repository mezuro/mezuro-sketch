require 'spec_helper'

describe UsersController do
  fixtures :users, :projects

  def mock_user()
    @mock_user ||= mock_model(User)
  end

  def valid_user_attributes(attributes={})
    {
      :login => "pika",
      :password => "gordo",
      :password_confirmation => "gordo",
      :email => "pika@agilbits.com"
    }.merge attributes
  end

  context "GET new" do
    before :each do
      User.stub!(:new).and_return(mock_user)
      get :new
    end

    it "should be sucessful" do
      response.should be_success
    end

    it "should assign new user" do
      assigns[:user].should == mock_user
    end
  end

  context "POST create" do
    it "should create a user given valid attributes" do
      post :create, :user => valid_user_attributes
      user = User.find_by_login("pika")
      user.should_not be_nil
      flash[:message].should == "User successfully created"
      response.should redirect_to(user_path(user.login))
    end

    it "should not create a user given nil or empty login" do
      post :create, :user => valid_user_attributes(:login => nil)
      User.find_by_email('pika@agilbits.com').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)

      post :create, :user => valid_user_attributes(:login => "")
      User.find_by_email('pika@agilbits.com').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)
    end

    it "should not create a user given nil or empty password" do
      post :create, :user => valid_user_attributes(:password => nil)
      User.find_by_email('pika@agilbits.com').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)

      post :create, :user => valid_user_attributes(:password => "")
      User.find_by_email('pika@agilbits.com').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)
    end

    it "should not create a user given nil or empty email" do
      post :create, :user => valid_user_attributes(:email => nil)
      User.find_by_login('pika').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)

      post :create, :user => valid_user_attributes(:email => "")
      User.find_by_login('pika').should be_nil
      flash[:error].should == "User not created"
      response.should render_template(:new)
    end
    
  end

  context "GET show" do    
    it "should show user attributes given an id" do
      get :show, :login => users(:viviane).login
      assigns[:user].should == users(:viviane)
    end

    it "should have an empty list in @project if user doesnt have projects" do
      get :show, :login => users(:marcio).login
      assigns[:projects].should == []
    end

    it "should assign the users projects" do
      get :show, :login => users(:viviane).login
      ([projects(:analizo), projects(:my_project)] - assigns[:projects]).should == []
    end
  end

end
