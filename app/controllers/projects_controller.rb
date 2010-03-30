class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    @project  = Project.new(params[:project])
    if @project.save
      redirect_to(project_path(@project))
    else
      render :new
    end
  end

  def show
    @project = Project.find params[:id]
    @metrics = @project.metrics
  end

end
