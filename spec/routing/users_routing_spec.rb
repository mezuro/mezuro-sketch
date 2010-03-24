require 'spec_helper'

describe UsersController do

    it "should map /users/new to UsersController with new action" do
      route_for(:controller => 'users', :action => 'new').should == {:method => :get, :path => '/users/new'}

      params_from(:get, '/users/new').should == {:controller => 'users', :action => 'new'}
    end

    it "should map /users with method post to UsersController with create action" do
      route_for(:controller => 'users', :action => 'create').should == {:method => :post , :path => '/users'}

      params_from(:post, '/users').should == {:controller => 'users', :action => 'create'}
    end

end
