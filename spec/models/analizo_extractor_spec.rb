require 'spec_helper'
require 'resources/hello_world_output'
require 'resources/hello_world_project'
require 'resources/analizo_extractor_test_subclass'

describe AnalizoExtractor do
  fixtures :projects

  def valid_analizo_hash(attributes={})
    {
        :acc_average => "0.5",
        :acc_kurtosis => "0",
        :acc_maximum => "1",
        :acc_median => "0.5",
        :acc_mininum => "0"
    }.merge attributes
  end

 context "running analizo and saving metrics" do
    before :each do
      @source = "#{RAILS_ROOT}/spec/resources/hello-world"
      @destination = "#{RAILS_ROOT}/tmp/hello"
      FileUtils.cp_r @source, @destination

      @project = projects(:hello)
      @extractor = AnalizoExtractor.new @project
    end

    after :each do
      FileUtils.rm_rf @destination
    end

    it "should run all steps to collect metric" do
      initial_count = Metric.count      
      @extractor.perform
      final_count = Metric.count
      (initial_count < final_count).should == true
    end 
  end

  context "running analizo with existent project" do
    before :each do
      @source = "#{RAILS_ROOT}/spec/resources/hello-world"
      @destination = "#{RAILS_ROOT}/tmp/hello-world"
      FileUtils.cp_r @source, @destination
    end

    after :each do
      FileUtils.rm_rf @destination
    end

    it "should run analizo and get its output" do
      project = HelloWorldProject.new
      extractor = AnalizoExtractor.new(project)
      extractor.run_analizo
      extractor.string_output.should == HELLO_WORLD_OUTPUT
    end
  end

  context "giving Analizo hash" do
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

      project = HelloWorldProject.new
      @extractor = AnalizoExtractorTestSubclass.new project
    end

    it "should return a hash metric_name => value" do
      test_average = "acc_average: 0.5#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.5" }
      @extractor.string_output = test_average
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with a different acc_average value" do
      test_average = "acc_average: 0.9#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.9" }
      @extractor.string_output = test_average
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with another different acc_average value" do
      test_average = "acc_average: 0.7#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "0.7" }
      @extractor.string_output = test_average
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with a '~' as acc_average value" do
      test_average = "acc_average: ~#{@valid_analizo_output_without_average}"
      expected = { :acc_average => "~" }
      @extractor.string_output = test_average
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value with a different acc_kurtosis value" do
      test_kurtosis = "acc_kurtosis: 0.7#{@valid_analizo_output_without_kurtosis}"
      expected = { :acc_kurtosis => "0.7" }
      @extractor.string_output = test_kurtosis
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end

    it "should return a hash in metric_name => value from a bigger analizo output" do
      test_bigger_output = @valid_analizo_output_extended
      expected = { :acc_mode => "~" }
      @extractor.string_output = test_bigger_output
      @extractor.create_hash
      @extractor.hash_output.should == valid_analizo_hash(expected)
    end
    
    it "should not have metric name accm" do
      @extractor.string_output = HELLO_WORLD_OUTPUT
      @extractor.create_hash
      hash = @extractor.hash_output
      hash[:accm].should be_nil    
    end
  end
 
  context "persisting metrics" do
    before :each do
      @project = HelloWorldProject.new
      @extractor = AnalizoExtractorTestSubclass.new @project
    end

    it "should save metrics in the database" do
      initial_count = Metric.count
      @extractor.string_output = HELLO_WORLD_OUTPUT
      @extractor.create_hash
      @extractor.save_metrics
      final_count = Metric.count
      (initial_count - final_count).should_not == true
    end 
  end    

end
