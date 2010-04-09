require 'spec_helper'

describe UserSession do
  fixtures :users

  def valid_attributes(attributes={})
    {
      :login => "viviane",
      :password => "minhasenha",
    }.merge attributes
  end

  it "should create a new instance given valid attributes" do
    UserSession.create!(valid_attributes)
  end
end