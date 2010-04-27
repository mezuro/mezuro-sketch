class Metric < ActiveRecord::Base
  validates_presence_of :name, :project_id
end