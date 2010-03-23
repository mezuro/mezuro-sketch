require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show" do
  before :each do
    assigns[:metrics] = {"noa" => 4, "loc" => 10, "nom" => 2}
    render
  end

  it "should have a title: Metric Results" do
    response.should have_tag("h3", "Metric Results")
  end

  it "should have a table with metric results" do
    response.should have_tag("table") do
      with_tag("tr[id=?]", "tr_noa") do
        with_tag("td", "noa")
        with_tag("td", "4")
      end
      with_tag("tr[id=?]", "tr_loc") do
        with_tag("td", "loc")
        with_tag("td", "10")
      end
    end
  end
end