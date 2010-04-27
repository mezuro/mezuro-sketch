class ProjectMock < Project
  attr_reader :called_metrics

  def initialize params
    super params
    @called_metrics = false
  end

  def metrics
    @called_metrics = true
  end
end