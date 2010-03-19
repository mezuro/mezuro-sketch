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
      with_tag("input[id=?][type=?]", "project_name", "text")
      with_tag("label", "Repository URL")
      with_tag("input[id=?][type=?]", "project_repository_url", "text")
      with_tag("label", "Description")
      with_tag("input[id=?][type=?]", "project_description", "text")
      with_tag("input[id=?][type=?]", "project_submit", "submit")
    end
  end
end