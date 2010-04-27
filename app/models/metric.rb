class Metric < ActiveRecord::Base
  validates_presence_of :name, :project_id

  belongs_to :project
end