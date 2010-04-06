class Project < ActiveRecord::Base
  validates_presence_of :name, :repository_url, :identifier

  validates_format_of :identifier, :with => /^[a-z0-9|\-|\.]+$/

  validates_uniqueness_of :identifier

  def metrics
    {"noa" => 4, "loc" => 10, "nom" => 2}
  end

  def run_analizo
    project_path = "#{RAILS_ROOT}/tmp/#{identifier}"
    raise "Missing project folder" unless File.exists? project_path
    `analizo-metrics #{project_path}`
  end
end
