require 'spec_helper'

describe UsersController do
  fixtures :users

  def mock_user()
    @mock_user ||= mock_model(User)
  end

  def valid_project_attributes(attributes={})
    {
      :login => "pika",
      :password => "gordo",
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
      post :create, :user => valid_project_attributes
      User.find_by_login("pika").should_not be_nil
    end

    it "should not create a user given nil or empty login" do
      post :create, :user => valid_project_attributes(:login => nil)
      User.find_by_email('pika@agilbits.com').should be_nil
      response.should render_template(:new)

      post :create, :user => valid_project_attributes(:login => "")
      User.find_by_email('pika@agilbits.com').should be_nil
      response.should render_template(:new)
    end

    it "should not create a user given nil or empty password" do
      post :create, :user => valid_project_attributes(:password => nil)
      User.find_by_email('pika@agilbits.com').should be_nil
      response.should render_template(:new)

      post :create, :user => valid_project_attributes(:password => "")
      User.find_by_email('pika@agilbits.com').should be_nil
      response.should render_template(:new)
    end

    it "should not create a user given nil or empty email" do
      post :create, :user => valid_project_attributes(:email => nil)
      User.find_by_login('pika').should be_nil
      response.should render_template(:new)

      post :create, :user => valid_project_attributes(:email => "")
      User.find_by_login('pika').should be_nil
      response.should render_template(:new)
    end
    
  end

end