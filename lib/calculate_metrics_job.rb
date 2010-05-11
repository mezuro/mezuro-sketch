class CalculateMetricsJob < Struct.new(:project_id)
  def perform
    project = Project.find project_id
    project.calculate_metrics
  end
end

