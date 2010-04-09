require 'spec_helper'
require 'resources/hello_world_output'

describe Project do

  def valid_project_attributes(attributes={})
    {
      :name => "Hello World",
      :identifier => "hello-world",
      :repository_url => "rep@rep.com/myrepo",
      :description => "This project is awesome",
      :personal_webpage => "http://mywebpage.com"
    }.merge attributes
  end

  def valid_analizo_hash(attributes={})
    {
        :acc_average => "0.5",
        :acc_kurtosis => "0",
        :acc_maximum => "1",
        :acc_median => "0.5",
        :acc_mininum => "0"
    }.merge attributes
  end

  it "should create a new instance given valid attributes" do
    Project.create!(valid_project_attributes)
  end

  context "creating instances with invalid attributes" do
    it "should not create a new instance given invalid name" do
      project = Project.new(valid_project_attributes(:name => nil))
      project.save.should == false

      project = Project.new(valid_project_attributes(:name => ""))
      project.save.should == false
    end


    it "should not create a new instance given invalid url" do
      project = Project.new(valid_project_attributes(:repository_url => nil))
      project.save.should == false

      project = Project.new(valid_project_attributes(:repository_url => ""))
      project.save.should == false
    end
  end


  context "validating identifier" do
    it "should not create a new instance given invalid description" do
      project = Project.new(valid_project_attributes(:identifier => nil))
      project.save.should == false

      project = Project.new(valid_project_attributes(:identifier => ""))
      project.save.should == false
    end

    it "should not create a new instance given an identifier with capital letters" do
      project = Project.new(valid_project_attributes(:identifier => "Letter"))
      project.save.should == false
    end

    it "should create a new instance given an identifier with '-' " do
      project = Project.new(valid_project_attributes(:identifier => "seperate-letter"))
      project.save.should == true
    end

    it "should create a new instance given an identifier with number" do
      project = Project.new(valid_project_attributes(:identifier => "letter2010"))
      project.save.should == true
    end

    it "should create an instance given an identifier with dots" do
      project = Project.new(valid_project_attributes(:identifier => "letter.2010.project"))
      project.save.should == true
    end

    it "should only create an instance given an unique identifier" do
      Project.create!(valid_project_attributes(:identifier => "letter.2010.project"))
      project = Project.new(valid_project_attributes(:identifier => "letter.2010.project"))
      project.save.should == false
    end

  end

  context "giving metrics" do
    before :each do
      @source = "#{RAILS_ROOT}/spec/resources/hello-world"
      @destination = "#{RAILS_ROOT}/tmp/hello-world"
      FileUtils.cp_r @source, @destination
    end

    after :each do
      FileUtils.rm_r @destination
    end

    it "should be 10 to loc, 2 to nom and 4 to noa" do
      project = Project.new valid_project_attributes
      project.metrics.should == {"loc" => 10,
                                 "nom" => 2,
                                 "noa" => 4
      }
    end

    it "should run analizo and get its output" do
      project = Project.new valid_project_attributes
      project.run_analizo.should == HELLO_WORLD_OUTPUT
    end
  end
  
  context "running analizo without project folder" do
    it "should not run analizo when project folder doesnt exist" do
      project = Project.new valid_project_attributes
      lambda {project.run_analizo}.should raise_error("Missing project folder")
    end
  end

  context "giving Analizo output" do
    before :each do
      @valid_analizo_output_without_average = "
                      acc_kurtosis: 0
                      acc_maximum: 1
                      acc_median: 0.5
                      acc_mininum: 0"

      @valid_analizo_output_without_kurtosis = "
                      acc_average: 0.5
                      acc_maximum: 1
                      acc_median: 0.5
                      acc_mininum: 0"

      @valid_analizo_output_extended = "
                      acc_average: 0.5
                      acc_kurtosis: 0
                      acc_maximum: 1
                      acc_median: 0.5
                      acc_mininum: 0
                      acc_mode: ~"
    end

    it "should return a hash metric_name => value" do
      project = Project.new valid_project_attributes
      test_average = "acc_average: 0.5#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.5" }
      project.analizo_hash(test_average).should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with a different acc_average value" do
      project = Project.new valid_project_attributes
      test_average = "acc_average: 0.9#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.9" }
      project.analizo_hash(test_average).should == valid_analizo_hash(expected)
    end
    
    it "should return a hash in metric_name => value with another different acc_average value" do
      project = Project.new valid_project_attributes
      test_average = "acc_average: 0.7#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.7" }
      project.analizo_hash(test_average).should == valid_analizo_hash(expected)
    end
    
    it "should return a hash in metric_name => value with a '~' as acc_average value" do
      project = Project.new valid_project_attributes
      test_average = "acc_average: ~#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "~" }
      project.analizo_hash(test_average).should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with a different acc_kurtosis value" do
      project = Project.new valid_project_attributes
      test_kurtosis = "acc_kurtosis: 0.7#{@valid_analizo_output_without_kurtosis}"
      expected = { :acc_kurtosis => "0.7" }
      project.analizo_hash(test_kurtosis).should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value from a bigger analizo output" do
      project = Project.new valid_project_attributes
      test_bigger_output = @valid_analizo_output_extended
      expected = { :acc_mode => "~" }
      project.analizo_hash(test_bigger_output).should == valid_analizo_hash(expected)
    end

  end
end
