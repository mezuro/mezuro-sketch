require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/new" do
  context "without errors" do
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

  context "with errors" do
    before :each do
      project = Project.new
      project.errors.add :name, "Missing name." 
      assigns[:project] = project
      render
    end
    
    it "should have an error div if 'project' contains errors" do
      response.should have_tag("div[class=?]", "errorExplanation")
    end
  end
end