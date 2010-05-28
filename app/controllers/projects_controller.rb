class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    @project  = Project.new(params[:project])
    if @project.save
      flash[:message] = "Project successfully registered"
      redirect_to user_path(@project.user.login)
    else
      render :new
    end
  end

  def show
    @project = Project.find_by_identifier params[:identifier]

    #TODO: Take off @metrics, because @metrics_totals and @metrics_stats are enough
    @metrics = @project.metrics if @project != nil
    
    @metrics_totals = @project.metrics_totals if @project != nil
    @metrics_stats = @project.metrics_stats if @project != nil
    
    @svn_error = @project.svn_error if (@project != nil && @project.svn_error)
  end

  def index
    @projects = Project.find :all
  end

end
