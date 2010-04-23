require 'spec_helper'

describe Metric do
  def valid_user_attributes(attributes={})
    {
      :name => "acc",
      :value => "1",
      :project_id => ""
    }.merge attributes
  end

  it "should create a new instance" do
    Metric.create!()
  end
end
