require 'spec_helper'

describe ProjectsController do

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
  
  describe "POST create" do
    it "should create a project given valid attributes" do
      post :create, :project => {:name => 'Projeto Mezuro',
        :description => 'Projeto para visualização de métricas',
        :repository_url => 'git://github.com/paulormm/mezuro.git'}
      Project.find_by_name("Projeto Mezuro").should_not be_nil
    end

    it "should not create a project given nil attributes" do
      post :create, :project => {:name => nil,
        :description => nil,
        :repository_url => nil}
      Project.find_by_name(nil).should be_nil
    end


  end

end
