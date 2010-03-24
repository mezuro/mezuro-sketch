class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    puts "-----------------------------\n\n\n\n\n"
    puts params.inspect
    puts "\n\n\n\n\n+++++++++++++++++++++++++++++"
    @project  = Project.new(params[:project])
    if @project.save
      
    else
      render :new
    end
  end

  def show
    project = Project.find params[:id]
    @metrics = project.metrics
  end

end
