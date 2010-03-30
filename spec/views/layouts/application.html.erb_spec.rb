require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/layouts/application" do
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