class ProjectMock < Project
  attr_reader :called_calculate_metrics

  def initialize params
    super params
    @called_calculate_metrics = false
  end

  def calculate_metrics
    @called_calculate_metrics = true
  end
end