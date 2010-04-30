class Metric < ActiveRecord::Base
  validates_presence_of :name, :project_id

  belongs_to :project
  
  def initialize params
    params[:value] = nil if params[:value] == '~'
    super params
  end
end
