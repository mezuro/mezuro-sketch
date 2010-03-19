require 'spec_helper'

describe ProjectsController do

  it "should map index of new ProjectController to '/projects/new'" do
    params_from(:get, '/projects/new').should == {:controller => 'projects', :action => 'new'}

    route_for(:action => 'new', :controller => 'projects').should == '/projects/new'
  end

end
