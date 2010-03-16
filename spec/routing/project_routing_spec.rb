require 'spec_helper'

describe ProjectController do

  it "should map index of new ProjectController to '/project/new'" do
    route_for(:action => 'new', :controller => 'project').should == '/project/new'
  end

end
