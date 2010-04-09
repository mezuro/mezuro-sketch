require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show" do
   before :each do
    assigns[:user] = User.new(:login => "pika",
      :password => "gordo",
      :password_confirmation => "gordo",
      :email => "pika@agilbits.com")
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
    with_tag("tr[id=?]", "tr_user_password") do
      with_tag("td", "Password")
      with_tag("td", "gordo")
    end
    with_tag("tr[id=?]", "tr_user_password_confirmation") do
      with_tag("td", "Password confirmation")
      with_tag("td", "gordo")
    end
  end
  

end

