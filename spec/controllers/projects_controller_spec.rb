require 'spec_helper'

describe ProjectsController do

  def mock_project(stubs = {})
    @mock_project ||= mock_model(Project, stubs)
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
  
  context "POST create" do
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
      response.should render_template(:new)
    end

    it "should redirect to project show when create is success" do
      post :create, :project => {:name => 'Projeto Mezuro',
        :description => 'Projeto para visualização de métricas',
        :repository_url => 'git://github.com/paulormm/mezuro.git'}
      project = Project.find_by_name("Projeto Mezuro")
      response.should redirect_to(project_path(project))
    end

  end

  context "GET show" do
    before :each do
      @expected = {"noa" => 4, "loc" => 10, "nom" => 2}
      Project.stub!(:find).and_return(mock_project({:metrics => @expected}))
    end

    it "should assign to @metrics the metrics hash" do
      get :show, :id => 1
      assigns[:metrics].should == @expected
    end

    it "should assign to @project the project" do
      get :show, :id => 1
      assigns[:project].should == mock_project({:metrics => @expected})
    end

  end

end
