require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show" do

  context "user has projects" do
    fixtures :projects, :users, :metrics
    before :each do
      assigns[:user] = users(:viviane)
      assigns[:projects] = [projects(:my_project), projects(:in_progress), projects(:project_with_error)]
      render
    end
  
    it "should have a title: User Info" do
      response.should have_tag("h1", "User Info")
    end

    it "should have a table with user info" do
      response.should have_tag("table") do
        with_tag("tr[id=?]", "tr_user_login") do
          with_tag("td", "Login")
          with_tag("td", "viviane")
        end
        with_tag("tr[id=?]", "tr_user_email") do
          with_tag("td", "Email")
          with_tag("td", "vivi@qualquercoisa.com")
        end   
        with_tag("tr[id=?]", "tr_user_creation_date") do
          with_tag("td", "Member since")
          with_tag("td", "28 May 2010")
        end
      end
    end

    it "should have a title for user projects list" do
      response.should have_tag("h3", "Public Projects")
    end

    it "should have a list of user projects" do
      response.should have_tag("ul") do
        with_tag("li") do
          project = projects(:my_project)
          with_tag("p[class=?]", "project_name", project.name)
          with_tag("p[class=?]", "project_last_analysis", "Last analysis: 28 May 2010")
          with_tag("div[class=?]", "project_status") do
            with_tag("span[id=?]", "project_status_#{ project.id }")do
              with_tag("a", "Metrics calculated", project_path(project.identifier))
            end
          end
          with_tag("div[class=?]", "project_description", project.description)
        end
        with_tag("li") do
          project = projects(:project_with_error)
          with_tag("p[class=?]", "project_name", project.name)
          with_tag("p[class=?]", "project_last_analysis", "Last analysis: 30 May 2010")
          with_tag("div[class=?]", "project_status") do
            with_tag("span[id=?]", "project_status_#{ project.id }")do
              with_tag("a", "Error Found",  project_path(project.identifier))
            end
          end
          with_tag("div[class=?]", "project_description", project.description)
        end
        with_tag("li") do
          project = projects(:in_progress)
          with_tag("p[class=?]", "project_name", project.name)
          with_tag("p[class=?]", "project_last_analysis", "Last analysis: 08 Jun 2010")
          with_tag("div[class=?]", "project_status") do
            with_tag("span[id=?]", "project_status_#{ project.id }")do
              with_tag("p", "Analysis in progress")
            end
          end
          with_tag("div[class=?]", "project_description", project.description)
        end
      end
    end 
  end

  context "user doesn't have projects" do
    before :each do
      assigns[:user] = User.new(:login => "vinicius",
        :password => "magro",
        :password_confirmation => "magro",
        :email => "vinicius@qualquercoisa.com",
        :created_at => "28 May 2010")
      assigns[:projects] = []
      render
    end

    it "should not have a title for user projects list" do
      response.should_not have_tag("h3", "List of User Projects")
    end

    it "should have a link to new project" do 
      response.should have_tag("h3") do
        with_tag("a[href=?]", new_project_path)
      end
    end
  end
 end
