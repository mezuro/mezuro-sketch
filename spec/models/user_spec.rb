require 'spec_helper'

describe User do

  def valid_project_attributes(attributes={})
    {
      :login => "user_login",
      :password => "user_password",
      :email => "name@place.com",
    }.merge attributes
  end

  it "should create an instance given valid attributes" do
    User.create!(valid_project_attributes)
  end

  context "creating user with invalid attributes" do
    it "should not create an instance given invalid login" do
      user = User.new(valid_project_attributes(:login => nil))
      user.save.should == false

      user = User.new(valid_project_attributes(:login => ""))
      user.save.should == false
    end

    it "should not create an instance given invalid password" do
      user = User.new(valid_project_attributes(:password => nil))
      user.save.should == false

      user = User.new(valid_project_attributes(:password => ""))
      user.save.should == false
    end

    it "should not create an instance given invalid e-mail" do
      user = User.new(valid_project_attributes(:email => nil))
      user.save.should == false

      user = User.new(valid_project_attributes(:email => ""))
      user.save.should == false
    end     
  end

  context "validating e-mail" do
    it "should not create an instance when e-mail is without @" do
      user = User.new(valid_project_attributes(:email => "name_at_place.com"))
      user.save.should == false      
    end
  end

  context "validating login" do
    it "should only create an instance given an unique login" do
      User.create!(valid_project_attributes(:login => "pika"))
      user = User.new(valid_project_attributes(:login => "pika"))
      user.save.should == false
    end
  end

end