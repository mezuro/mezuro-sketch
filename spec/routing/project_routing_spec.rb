require 'spec_helper'

describe ProjectController do

  it "should map index of new ProjectController to '/project/new'" do
    params_from(:get, '/project/new').should == {:controller => 'project', :action => 'new'}

    route_for(:action => 'new', :controller => 'project').should == '/project/new'
  end

end
