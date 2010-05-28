require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show" do
  fixtures :projects
  before :each do
    assigns[:user] = User.new(:login => "pika",
      :password => "gordo",
      :password_confirmation => "gordo",
      :email => "pika@agilbits.com")
    assigns[:projects] = [projects(:my_project), projects(:analizo)]
    render
  end

  it "should have a title: User Info" do
    response.should have_tag("h1", "User Info")
  end

  it "should have a table with user info" do
    response.should have_tag("table") do
      with_tag("tr[id=?]", "tr_user_login") do
        with_tag("td", "Login")
        with_tag("td", "pika")
      end
    end
    with_tag("tr[id=?]", "tr_user_email") do
      with_tag("td", "Email")
      with_tag("td", "pika@agilbits.com")
    end   
  end

  it "should have a title for user projects list" do
    response.should have_tag("h3", "List of User Projects")
  end

  it "should have a list of user projects" do
    response.should have_tag("ul") do
      with_tag("li") do
        with_tag("a", projects(:my_project).name, project_path(projects(:my_project).identifier))
      end
      with_tag("li") do
        with_tag("a", projects(:analizo).name, project_path(projects(:analizo).identifier))
      end
    end
  end 

end
