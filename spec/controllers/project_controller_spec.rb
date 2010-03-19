require 'spec_helper'

describe ProjectController do

  def mock_project
    @mock_project ||= mock_model(Project)
  end

  context "GET new" do
    before :each do
      Project.stub!(:new).and_return(mock_project)
      get :new
    end

    it "should be sucessful" do
      response.should be_success
    end

    it "should assign new project" do
      assigns[:project].should == mock_project
    end

  end
end
