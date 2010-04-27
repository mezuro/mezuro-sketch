require 'spec_helper'
require 'resources/hello_world_output'

describe Project do
  before :all do
    FileUtils.mkdir "#{RAILS_ROOT}/tmp" unless File.exists? "#{RAILS_ROOT}/tmp"
  end

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

  context "downloading project source code" do
    before :all do
      require "resources/svn_mock"
      require "resources/hello_world_hash"
    end


    it "should delete project diretory if it exists" do
      source = "#{RAILS_ROOT}/spec/resources/hello-world"
      destination = "#{RAILS_ROOT}/tmp/hello-world"
      FileUtils.cp_r source, destination
      
      project = Project.new(valid_project_attributes)
      project.download_prepare
      File.exists?(destination).should == false
    end
    
    it "should download a project source-code to /tmp" do
      project = Project.new(valid_project_attributes(:identifier => "projeto1"))
      project.download_source_code
      File.exists?("#{RAILS_ROOT}/tmp/#{project.identifier}").should == true
    end

    it "should check, delete and create a project directory" do
      project = Project.new(valid_project_attributes(:identifier => "projeto1"))
      FileUtils.mkdir_p "#{RAILS_ROOT}/tmp/#{project.identifier}/src"

      project.metrics

      File.exists?("#{RAILS_ROOT}/tmp/#{project.identifier}/src").should == false
      File.exists?("#{RAILS_ROOT}/tmp/#{project.identifier}").should == true
      FileUtils.rm_rf "#{RAILS_ROOT}/tmp/#{project.identifier}"
    end

    it "given valid attributes return the correct hash" do
      project = Project.new(valid_project_attributes)
      project.metrics.should == HELLO_WORLD_HASH
      FileUtils.rm_r "#{RAILS_ROOT}/tmp/#{project.identifier}"
    end
  end

  context "downloading project from invalid repository" do
    it "should raise an error when downloading source code" do
      project = Project.new(valid_project_attributes(:repository_url => "invalid"))
      lambda {project.download_source_code}.should raise_error(Svn::Error)
    end
    
    it "should return a hash with an error" do
      project = Project.new(valid_project_attributes(:repository_url => "invalid"))
      project.metrics.should == {"Error:" => "'.' is not a working copy\nCan't open file '.svn/entries': No such file or directory"}
    end

    it "should raise an error when downloading source code that we dont have permission" do
      project = Project.new(valid_project_attributes(:repository_url => "http://svn.xp-dev.com/svn/horus_eye/"))
      lambda {project.download_source_code}.should raise_error(Svn::Error)
      project.metrics.should == {"Error:" => "OPTIONS of 'http://svn.xp-dev.com/svn/horus_eye': authorization failed (http://svn.xp-dev.com)"}
    end
  end

  context "running analizo with existent project" do
    before :each do
      @source = "#{RAILS_ROOT}/spec/resources/hello-world"
      @destination = "#{RAILS_ROOT}/tmp/hello-world"
      FileUtils.cp_r @source, @destination
    end

    after :each do
      FileUtils.rm_r @destination
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

  it "should calculates metrics on create" do
    require 'resources/project_mock'
    project = ProjectMock.new valid_project_attributes
    project.called_metrics.should be_false
    project.save
    project.called_metrics.should be_true
  end
end
