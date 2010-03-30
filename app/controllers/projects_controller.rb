class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    @project  = Project.new(params[:project])
    if @project.save
      redirect_to(project_path(@project.identifier))
    else
      render :new
    end
  end

  def show
    @project = Project.find_by_identifier params[:identifier]
    @metrics = @project.metrics if @project != nil
  end

end
