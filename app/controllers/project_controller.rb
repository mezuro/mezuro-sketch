class ProjectController < ApplicationController
  def create
    Project.create(params[:project])
  end 
end
