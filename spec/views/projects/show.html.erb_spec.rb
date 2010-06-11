require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show" do
  fixtures :projects, :metrics

  context "Project information area" do
  
    before :each do
      assigns[:project] = projects(:analizo)
      assigns[:metrics_totals] = [metrics(:noc), metrics(:loc)]
      assigns[:metrics_stats] = [metrics(:noc), metrics(:loc)]
    end
  
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
  
  context "Metrics calculated" do
    before :each do
      assigns[:project] = projects(:jmeter)
      assigns[:metrics_totals] = [metrics(:total_modules_jmeter),
                                  metrics(:total_nom_jmeter),
                                  metrics(:total_tloc_jmeter)]
      assigns[:metrics_stats] = [metrics(:accm_median_jmeter),
                                 metrics(:accm_average_jmeter),
                                 metrics(:accm_mode_jmeter)]
      render
    end
    
    it "should have a Total Metrics heading" do
      response.should have_tag("h3","Total Metrics")
    end
    
    it "should have a table with total metrics results" do
      response.should have_tag("table[id=?]", "metrics_totals") do
        with_tag("tr[id=?]", "tr_total_modules") do
          with_tag("td[class=?]", "metric_name", "total_modules")
          with_tag("td[class=?]", "metric_value", "2.0")
        end
        with_tag("tr[id=?]", "tr_total_nom") do
          with_tag("td[class=?]", "metric_name", "total_nom")
          with_tag("td[class=?]", "metric_value", "5.0")
        end
        with_tag("tr[id=?]", "tr_total_tloc") do
          with_tag("td[class=?]", "metric_name", "total_tloc")
          with_tag("td[class=?]", "metric_value", "26.0")
        end
      end
    end
    
    it "should have a Statistical Metrics heading" do
      response.should have_tag("h3","Statistical Metrics")
    end

    
    it "should have a table with statistical metrics results" do
      response.should have_tag("div[id=?]", "metrics_stats") do
        with_tag("div[id=?]", "div_accm") do
          with_tag("img")
          with_tag("p", "accm_average 0.45")
          with_tag("span[id=?]", "span_accm") do
            with_tag("table") do
              with_tag("tr[id=?]", "tr_accm_median") do
                with_tag("td[class=?]", "metric_name", "accm_median")
                with_tag("td[class=?]", "metric_value", "1.45")
              end
              with_tag("tr[id=?]", "tr_accm_mode") do
                with_tag("td[class=?]", "metric_name", "accm_mode")
                with_tag("td[class=?]", "metric_value", "2.0")
              end
            end
          end
        end
      end
    end
  end
  
  context "General layout components" do
    before :each do
      assigns[:project] = projects(:jmeter)
      assigns[:metrics_totals] = [metrics(:total_modules_jmeter),
                                  metrics(:total_nom_jmeter),
                                  metrics(:total_tloc_jmeter)]
      assigns[:metrics_stats] = [metrics(:accm_median_jmeter),
                                 metrics(:accm_average_jmeter)]
      assigns[:metrics] = [metrics(:noc), metrics(:loc)]
      assigns[:svn_error] = nil
      render
    end
    
    it "should have a back link" do
      response.should have_tag("a", "back")
    end
    
    it "should have a title: Project Info" do
      response.should have_tag("h1", "Jmeter's Info")
    end
    
    it "should have a title: Metric Results" do
      response.should have_tag("h3", "Metric Results")
    end
    
    it "should not show a svn_error if the project is ok" do
      response.should_not have_tag("div[id=?]", "svn_error")
    end
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
      assigns[:project] = Project.new      
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
end
