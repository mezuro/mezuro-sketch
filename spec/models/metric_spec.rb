require 'spec_helper'

describe Metric do
  def valid_metric_attributes(attributes={})
    {
      :name => "acc",
      :value => 10,
      :project_id => 1
    }.merge attributes
  end

  it "should create a new instance" do
    Metric.create!()
  end
end
