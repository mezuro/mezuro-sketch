require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/new" do

  before :each do
    assigns[:project] = Project.new
    render
  end

  it "should have a title: New Project" do
    response.should have_tag("h1", "New Project")
  end

  it "should have a form" do
    response.should have_tag("form") do
      with_tag("label", "Project Name")
      with_tag("input", :id => "project_name", :type => "text")
      with_tag("label", "Repository URL")
    end
  end
end