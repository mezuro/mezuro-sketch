require 'spec_helper'

describe UserSessionsController do
  it "should map /login to new usersessions controller" do
    params_from(:get, '/login').should == {:controller => 'user_sessions', :action => 'new'}

    route_for(:action => 'new', :controller => 'user_sessions').should == '/login'
  end

  it "should map /login with method post to UserSessionsController with create action" do
    params_from(:post, '/login').should == {:controller => 'user_sessions', :action => 'create'}
  end

  it "should map /logou with method delete to UserSessionsController with delete action" do
    params_from(:delete, '/logout').should == {:controller => 'user_sessions', :action => 'destroy'}
  end
end