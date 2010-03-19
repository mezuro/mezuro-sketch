class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    Project.create(params[:project])
  end
  
end
