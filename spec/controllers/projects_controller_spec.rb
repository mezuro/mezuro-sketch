require 'spec_helper'

describe ProjectsController do

  def mock_project(stubs = {})
    @mock_project ||= mock_model(Project, stubs)
  end

  def valid_attributes(attributes={})
    {
      :name => "Mezuro Project",
      :identifier => "mezuro",
      :repository_url => "rep://rep.com/myrepo",
      :description => "This project is awesome",
      :personal_webpage => "http://mywebpage.com"
    }.merge attributes
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
      post :create, :project => valid_attributes
      Project.find_by_name("Mezuro Project").should_not be_nil
    end

    it "should not create a project given nil or empty name" do
      post :create, :project => valid_attributes(:name => nil)
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_attributes(:name => "")
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)
    end

    it "should not create a project given nil or empty identifier" do
      post :create, :project => valid_attributes(:identifier => nil)
      Project.find_by_name('Mezuro Project').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_attributes(:identifier => "")
      Project.find_by_name('Mezuro Project').should be_nil
      response.should render_template(:new)
    end

    it "should not create a project given nil or empty repository url" do
      post :create, :project => valid_attributes(:repository_url => nil)
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_attributes(:repository_url => "")
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)
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
  end

end
