require 'spec_helper'

describe Project do

  def valid_attributes(attributes={})
    {
      :name => "super_project",
      :identifier => "identifier",
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
    Project.create!(valid_attributes)
  end

  context "creating instances with invalid attributes" do
    it "should not create a new instance given invalid name" do
      project = Project.new(valid_attributes(:name => nil))
      project.save.should == false

      project = Project.new(valid_attributes(:name => ""))
      project.save.should == false
    end


    it "should not create a new instance given invalid url" do
      project = Project.new(valid_attributes(:repository_url => nil))
      project.save.should == false

      project = Project.new(valid_attributes(:repository_url => ""))
      project.save.should == false
    end
  end


  context "validating identifier" do
    it "should not create a new instance given invalid description" do
      project = Project.new(valid_attributes(:identifier => nil))
      project.save.should == false

      project = Project.new(valid_attributes(:identifier => ""))
      project.save.should == false
    end

    it "should not create a new instance given an identifier with capital letters" do
      project = Project.new(valid_attributes(:identifier => "Letter"))
      project.save.should == false
    end

    it "should create a new instance given an identifier with '-' " do
      project = Project.new(valid_attributes(:identifier => "seperate-letter"))
      project.save.should == true
    end

    it "should create a new instance given an identifier with number" do
      project = Project.new(valid_attributes(:identifier => "letter2010"))
      project.save.should == true
    end

    it "should create an instance given an identifier with dots" do
      project = Project.new(valid_attributes(:identifier => "letter.2010.project"))
      project.save.should == true
    end

    it "should only create an instance given an unique identifier" do
      Project.create!(valid_attributes(:identifier => "letter.2010.project"))
      project = Project.new(valid_attributes(:identifier => "letter.2010.project"))
      project.save.should == false
    end

  end

  context "giving metrics" do
    it "should be 10 to loc, 2 to nom and 4 to noa" do
      project = Project.new valid_attributes
      project.metrics.should == {"loc" => 10,
                                 "nom" => 2,
                                 "noa" => 4
      }
    end
  end

  context "giving Analizo output" do
    before :each do
      @valid_analizo_output = "
                      acc_kurtosis: 0
                      acc_maximum: 1
                      acc_median: 0.5
                      acc_mininum: 0"
    end

    it "should return a hash metric_name => value" do
      project = Project.new valid_attributes
      project.analizo_hash("acc_average: 0.5" + @valid_analizo_output).should == valid_analizo_hash(:acc_average => "0.5")
    end

    it "should return a hash in metric_name => value with a different acc_average value" do
      project = Project.new valid_attributes
      project.analizo_hash("acc_average: 0.9" + @valid_analizo_output).should == valid_analizo_hash(:acc_average => "0.9")
    end
    
    it "should return a hash in metric_name => value with a different acc_average value" do
      project = Project.new valid_attributes
      project.analizo_hash("acc_average: 0.7" + @valid_analizo_output).should == valid_analizo_hash(:acc_average => "0.7")
    end
    
    it "should return a hash in metric_name => value with a ~ as acc_average value" do
      project = Project.new valid_attributes
      project.analizo_hash("acc_average: ~" + @valid_analizo_output).should == valid_analizo_hash(:acc_average => "~")
    end
  end
end
