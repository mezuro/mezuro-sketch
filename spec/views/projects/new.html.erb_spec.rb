require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/new" do
  fixtures :users

  context "without errors" do
    before :each do
      login_as :viviane
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
        with_tag("label", "Identifier")
        with_tag("input[id=?][type=?]", "project_identifier", "text")
        with_tag("label", "Description")
        with_tag("textarea[id=?]", "project_description")
        with_tag("input[id=?][type=?]", "project_submit", "submit")
      end
    end

    it "should have a back button" do
      response.should have_tag("form") do
        with_tag("input[type=?][value=?]", "submit", "Back")
      end
    end

    it "should have user_id hidden field" do
      response.should have_tag("input[id=?]", "project_user_id")
    end
  end

  context "with errors" do
    before :each do
      login_as :viviane
    end
   
    it "should have an error div if 'project' contains errors" do
      project = Project.new
      project.errors.add :name, "Missing name."
      assigns[:project] = project
      render
      response.should have_tag("div[class=?]", "errorExplanation")
    end

    it "should have an error messange if 'identifier' has invalid characteres" do
      project = Project.new(:identifier => "wrong_Identifier_")
      project.save
      assigns[:project] = project
      render
      response.should include_text("can only have a combination of lower case, number, hyphen and dot!")
    end
  end
end
