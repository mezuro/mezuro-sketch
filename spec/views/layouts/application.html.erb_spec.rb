require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/layouts/application" do
  fixtures :users

  context "working as a layout" do
    before :each do
      flash[:message] = "Test"
      render "/spec/resources/layout_stub.html.erb", :layout => "application"
    end

    it "should show flash messages" do
      response.should have_tag("p[id=?]", 'flash_messages', "Test")
    end

    it "should yield other views" do
      response.should include_text("layout_stub.html.erb")
    end
  end

  context "user not logged in" do
    before :each do
      logout
      render "/spec/resources/layout_stub.html.erb", :layout => "application"
    end

    it "should have a link to log in" do   
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", login_path)
      end
    end

    it "should have a link to create an user" do
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", new_user_path)
      end
    end

    it "should have a link to list all projects" do
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", projects_path)
      end
    end
  end

  context "user logged in" do
    before :each do
      login_as 'viviane'
      render "/spec/resources/layout_stub.html.erb", :layout => "application"
    end

    it "should not have a link to login" do
      response.should have_tag("div[id=?]", 'static_links') do
        without_tag("a[href=?]", login_path)
      end
    end

    it "should not have a link to create an user" do
      response.should have_tag("div[id=?]", 'static_links') do
        without_tag("a[href=?]", new_user_path)
      end
    end

    it "should have a link to logout" do
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", logout_path)
      end
    end

    it "should have a link to create a new project" do
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", new_project_path)
      end
    end

    it "should have a link to list all projects" do
      response.should have_tag("div[id=?]", 'static_links') do
        with_tag("a[href=?]", projects_path)
      end
    end

    it "should show the number of projects already created" do
      response.should have_tag ("p[id=?]", 'number_of_created_projects', 'projects')
    end
  end
end