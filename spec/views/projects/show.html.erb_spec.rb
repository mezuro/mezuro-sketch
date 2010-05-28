require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show" do
  fixtures :projects, :metrics

  before :each do
    assigns[:project] = projects(:analizo)
    assigns[:metrics] = [metrics(:noc), metrics(:loc)]
  end

  it "should have a title: Project Info" do
    render
    response.should have_tag("h1", "Analizo's Info")
  end

  context "Project information area" do
    
    it "should have a table with project info" do
      render
      response.should have_tag("table") do
        with_tag("tr[id=?]", "tr_project_description") do
          with_tag("td", "Description")
          with_tag("td", "Calculate metrics")
        end
        with_tag("tr[id=?]", "tr_project_repository_url") do
          with_tag("td", "Repository address")
          with_tag("td", "git@github.com/analizo")
        end
      end
    end

    it "should not show description label when project's description is nil" do
      assigns[:project].description = nil
      render
      response.should_not have_tag("td", "Description")    
    end
    
    it "should not show description label when project's description is empty string" do
      assigns[:project].description = ""
      render
      response.should_not have_tag("td", "Description")    
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

  it "should have a back link" do
    render
    response.should have_tag("a", "back")
  end

  context "metrics are not yet calculated" do
    before :each do
      assigns[:project] = Project.new
    end


    it "should have a message of progress" do
      render
      response.should have_tag("div[id=?]", "progress_message", "Wait a moment while the metrics are calculated.
      Reload the page manually in a few moment.")
    end
  end

  context "svn_error occured" do
    before :each do
      assigns[:svn_error] = "Blue screen of death"
      render      
    end

    it "should show a svn_error if the project is not ok" do
      response.should have_tag("div[id=?]", "svn_error", "Blue screen of death")
    end
    
    it "should show an error header insted of metrics results if the project is not ok" do
      response.should have_tag("h3", "ERROR")
      response.should_not have_tag("h3", "Metric Results")
    end

    it "should have instructions for the user to solve the error if the project is not ok" do
      response.should have_tag( "p", "Possible causes:
    
      
        Server is down
      
      
        URL invalid, in this case create another project with the correct URL
        (Sorry for the incovenience, we're working for a better solution)")
    end    
  end

  it "should not show a svn_error if the project is ok" do
    assigns[:svn_error] = nil
    render
    response.should_not have_tag("div[id=?]", "svn_error")
  end
    
end
