require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_sessions/new" do
  before :each do
    assigns[:user_session] = UserSession.new
    render
  end

  it "should have a title" do
    response.should have_tag("h1", "Login")
  end

  it "should have a form" do
      response.should have_tag("form") do
        with_tag("label", "Login")
        with_tag("input[id=?][type=?]", "user_session_login", "text")
        with_tag("label", "Password")
        with_tag("input[id=?][type=?]", "user_session_password", "password")
        with_tag("input[id=?][type=?]", "user_session_submit", "submit")
      end
    end
end