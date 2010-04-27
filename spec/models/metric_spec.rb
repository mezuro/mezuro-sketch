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
    Metric.create!(valid_metric_attributes)
  end

  it "should save information in database" do
    metric = Metric.new(valid_metric_attributes)
    metric.save.should == true
  end

  context "creating instances with invalid attributes" do
    it "should not save a metric without name" do
      metric = Metric.new(valid_metric_attributes(:name => nil))
      metric.save.should == false
    end

    it "should not save a metric without project_id" do
      metric = Metric.new(valid_metric_attributes(:project_id => nil))
      metric.save.should == false
    end
  end
end
