require 'spec_helper'

describe Project do

  def valid_attributes(attributes={})
    {
      :name => "value for name",
      :description => "value for description",
      :repository_url => "value for repository_url"
    }.merge attributes
  end

  it "should create a new instance given valid attributes" do
    Project.create!(valid_attributes)
  end

  context "creating instances with invalid attributes" do
    it "should not create a new instance given invalid name" do
      project = Project.new(valid_attributes(:name => nil))
      project.save.should == false
    end

    it "should not create a new instance given invalid description" do
      project = Project.new(valid_attributes(:description => nil))
      project.save.should == false
    end

    it "should not create a new instance given invalid url" do
      project = Project.new(valid_attributes(:repository_url => nil))
      project.save.should == false
    end
  end

  context "giving metrics" do
    it "should be 10 to loc, 2 to nom and 4 to noa" do
      project = Project.new valid_attributes
      project.metrics.should == {"loc" => 10,
                                 "nom" => 2,
                                 "noa" => 4
      }
    end
  end
end
