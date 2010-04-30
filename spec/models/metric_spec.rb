require 'spec_helper'

describe Metric do
  fixtures :projects

  def valid_metric_attributes(attributes={})
    {
      :name => "acc",
      :value => "10",
      :project_id => projects(:my_project).id
    }.merge attributes
  end

  it "should create a new instance" do
    Metric.create!(valid_metric_attributes)
  end

  it "should save information in database" do
    metric = Metric.new(valid_metric_attributes)
    metric.save.should == true
  end

  it "should belongs to a project" do
    metric = Metric.create!(valid_metric_attributes)
    metric.project.should == projects(:my_project)
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
  
  context "handling '~' metric value case" do
    it "should store nil as value" do
      metric = Metric.new(valid_metric_attributes(:value => '~'))
      metric.save.should == true
      found_metric = Metric.find(metric.id)
      found_metric.value.should == nil
    end
  end
end
