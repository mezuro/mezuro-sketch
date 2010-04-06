require 'spec_helper'

describe ProjectsController do

  it "should map index of new ProjectController to '/projects/new'" do
    params_from(:get, '/projects/new').should == {:controller => 'projects', :action => 'new'}

    route_for(:action => 'new', :controller => 'projects').should == '/projects/new'
  end

  it "should map project identifiers to its url" do
    route_for(:action => 'show', :controller => 'projects', :identifier => 'project-name').should == '/projects/project-name'

    params_from(:get, '/projects/project-test').should == {:controller => 'projects', :action => 'show', :identifier => 'project-test'}
  end

  it "should route root to project index" do
    params_from(:get, "/").should == {:controller => "projects", :action => "index"}
  end
  
end
