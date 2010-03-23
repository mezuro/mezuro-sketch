class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :repository_url

  def metrics
    {"noa" => 4, "loc" => 10, "nom" => 2}
  end
end
