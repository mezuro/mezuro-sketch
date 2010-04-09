require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new" do
  context "without errors" do
    before :each do
      assigns[:user] = User.new
      render
    end

    it "should have a title: New User" do
      response.should have_tag("h1", "New User")
    end

    it "should have a form" do
      response.should have_tag("form") do
        with_tag("label", "User Login")
        with_tag("input[id=?][type=?]", "user_login", "text")
        with_tag("label", "Password")
        with_tag("input[id=?][type=?]", "user_password", "password")
        with_tag("label", "Password Confirmation")
        with_tag("input[id=?][type=?]", "user_password_confirmation", "password")
        with_tag("label", "e-mail")
        with_tag("input[id=?][type=?]", "user_email", "text")
        with_tag("input[id=?][type=?]", "user_submit", "submit")
      end
    end

  end
end

