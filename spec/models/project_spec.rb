require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :repository_url => "value for repository_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end
