require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show" do
  before :each do
    assigns[:project] = Project.new(:name => 'Projeto Mezuro',
      :description => 'Projeto para visualização de métricas',
      :repository_url => 'git://github.com/paulormm/mezuro.git')
    assigns[:metrics] = {"noa" => 4, "loc" => 10, "nom" => 2}
    render
  end

  it "should have a title: Project Info" do
    response.should have_tag("h1", "Project Info")
  end

  it "should have a table with project info" do
    response.should have_tag("table") do
      with_tag("tr[id=?]", "tr_project_name") do
        with_tag("td", "Name") 
        with_tag("td", "Projeto Mezuro")
      end        
    end
    with_tag("tr[id=?]", "tr_project_description") do
      with_tag("td", "Description")
      with_tag("td", "Projeto para visualização de métricas")
    end
    with_tag("tr[id=?]", "tr_project_repository_url") do
      with_tag("td", "Repository address")
      with_tag("td", "git://github.com/paulormm/mezuro.git")
    end
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
