require 'spec_helper'

describe User do

  it "should create an instance given valid attributes" do
    User.create(:login => "pika", :password => "gordo", :email => "pika@agilbits.com")
  end
end