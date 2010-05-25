require 'spec_helper'

describe ProjectsController do
  fixtures :projects, :metrics, :users

  def mock_project()
    @mock_project ||= mock_model(Project)
  end

  def valid_project_attributes(attributes={})
    {
      :name => "Mezuro Project",
      :identifier => "mezuro",
      :repository_url => "rep://rep.com/myrepo",
      :description => "This project is awesome",
      :personal_webpage => "http://mywebpage.com",
      :user_id => users(:viviane).id
    }.merge attributes
  end

  context "GET new" do
    before :each do
      login_as :viviane
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
      post :create, :project => valid_project_attributes
      Project.find_by_name("Mezuro Project").should_not be_nil
      flash[:message].should == "Project successfully registered"
    end

    it "should not create a project given nil or empty name" do
      post :create, :project => valid_project_attributes(:name => nil)
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_project_attributes(:name => "")
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)
    end

    it "should not create a project given nil or empty identifier" do
      post :create, :project => valid_project_attributes(:identifier => nil)
      Project.find_by_name('Mezuro Project').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_project_attributes(:identifier => "")
      Project.find_by_name('Mezuro Project').should be_nil
      response.should render_template(:new)
    end

    it "should not create a project given nil or empty repository url" do
      post :create, :project => valid_project_attributes(:repository_url => nil)
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)

      post :create, :project => valid_project_attributes(:repository_url => "")
      Project.find_by_identifier('mezuro').should be_nil
      response.should render_template(:new)
    end

    it "should redirect to project show when create is success" do
      post :create, :project => valid_project_attributes
      project = Project.find_by_name("Mezuro Project")
      response.should redirect_to(user_path(users(:viviane).id))
    end

  end

  context "GET show" do
    before :each do
      require 'resources/hello_world_output'
      @expected = [metrics(:npv)]
      @expected_totals = [metrics(:total_modules_sorted_project),
                          metrics(:total_nom_sorted_project),
                          metrics(:total_tloc_sorted_project)]
      @expected_stats = [metrics(:loc_sorted_project),
                         metrics(:noc_sorted_project),
                         metrics(:npv_sorted_project)]
    end

    it "should assign to @metrics the metrics hash" do
      get :show, :identifier => projects(:my_project).identifier
      assigns[:metrics].should == @expected
    end

    it "should assign nil to @metrics when project is unknown" do
      get :show, :identifier => 'unknown'
      assigns[:metrics].should be_nil
    end

    it "should assign the total group metrics to @metrics_totals" do
      get :show, :identifier => projects(:sorted_project).identifier
      assigns[:metrics_totals].should == @expected_totals
    end

    it "should assign the statistics group metrics to @metrics_stats" do
      get :show, :identifier => projects(:sorted_project).identifier
      assigns[:metrics_stats].should == @expected_stats
    end

    it "should assign to @project the project" do
      get :show, :identifier => projects(:my_project).identifier
      assigns[:project].should == projects(:my_project)
    end
    
    it "should not assign to @svn_error the error message if the project is ok" do
      get :show, :identifier => projects(:my_project).identifier
      assigns[:svn_error].should == nil
    end
    
    it "should assign to @svn_error the error message if the project has an error" do
      project = projects(:project_with_error)
      get :show, :identifier => project.identifier
      assigns[:svn_error].should == project.svn_error
    end
  end

  context "GET index" do
    it "should assign to @projects all the projects" do
      all_projects = [projects(:my_project), projects(:analizo), projects(:project_with_error), projects(:in_progress), projects(:sorted_project)]
      get :index
      (assigns[:projects] - all_projects).should == []
    end
  end

  it "should count the number of created projects" do
    get :index
    assigns[:projects_count].should == 5
  end
end
