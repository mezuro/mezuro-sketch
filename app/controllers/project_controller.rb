class ProjectController < ApplicationController

  def new
    @project = Project.new
  end
  
end
