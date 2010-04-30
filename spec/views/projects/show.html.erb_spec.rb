require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show" do
  fixtures :projects, :metrics

  before :each do
    assigns[:project] = projects(:analizo)
    assigns[:metrics] = [metrics(:noc), metrics(:loc)]
  end

  it "should have a title: Project Info" do
    render
    response.should have_tag("h1", "Project Info")
  end

  it "should have a table with project info" do
    render
    response.should have_tag("table") do
      with_tag("tr[id=?]", "tr_project_name") do
        with_tag("td", "Name") 
        with_tag("td", "Analizo")
      end        
    end
    with_tag("tr[id=?]", "tr_project_description") do
      with_tag("td", "Description")
      with_tag("td", "Calculate metrics")
    end
    with_tag("tr[id=?]", "tr_project_repository_url") do
      with_tag("td", "Repository address")
      with_tag("td", "git@github.com/analizo")
    end
  end

  it "should have a title: Metric Results" do
    render
    response.should have_tag("h3", "Metric Results")
  end

  it "should have a table with metric results" do
    render
    response.should have_tag("table") do
      with_tag("tr[id=?]", "tr_noc") do
        with_tag("td", "noc")
        with_tag("td", "10.0")
      end
      with_tag("tr[id=?]", "tr_loc") do
        with_tag("td", "loc")
        with_tag("td", "5.0")
      end
    end
  end

  context "metrics are not yet calculated" do
    before :each do
      assigns[:project] = Project.new
    end


    it "should have a message of progress" do
      render
      response.should have_tag("div[id=?]", "progress_message", "Wait a moment while the metrics are calculated")
    end
  end

  context "svn_error occured" do
    it "should show a svn_error if the project is not ok" do
      assigns[:svn_error] = "Blue screen of death"
      render
      response.should have_tag("div[id=?]", "svn_error", "Blue screen of death")
    end
    
    it "should not show a svn_error if the project is ok" do
      assigns[:svn_error] = nil
      render
      response.should_not have_tag("div[id=?]", "svn_error")
    end
    
  end
end
