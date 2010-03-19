require 'spec_helper'

describe ProjectController do

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
