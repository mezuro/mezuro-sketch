require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/status" do
  fixtures :projects

  it "should return a message telling that metrics are being calculated" do
    assigns[:project] = projects(:in_progress)
    render
    response.should include_text("Metrics are being calculated")
  end
  
  it "should return a link to open the project if metrics are already calculated" do
    assigns[:project] = projects(:analizo)
    render
    response.should have_tag("a", "Metrics calculated")
  end
  
  it "should return a link to open the project if metrics have errors" do
    assigns[:project] = projects(:project_with_error)
    render
    response.should have_tag("a", "Error Found")
  end
end
