class Project < ActiveRecord::Base
  has_many :metrics
  validates_presence_of :name, :repository_url, :identifier

  validates_format_of :identifier, :with => /^[a-z0-9|\-|\.]+$/

  validates_uniqueness_of :identifier

  after_create :asynchronous_calculate_metrics

  def calculate_metrics
    begin
        download_source_code
        output = run_analizo
        analizo_hash(output).each do | key, value |
          Metric.create(:name => key.to_s, :value => value.to_f, :project => self)
        end
      rescue Svn::Error => error
        update_attribute :svn_error, error.error_message
      end
  end
  

  def asynchronous_calculate_metrics
    Delayed::Job.enqueue CalculateMetricsJob.new(id)
  end

  def download_source_code
    download_prepare
    Svn::Client::Context.new.checkout(repository_url, "#{RAILS_ROOT}/tmp/#{identifier}")
  end
  
  def download_prepare
    project_path = "#{RAILS_ROOT}/tmp/#{identifier}"
    FileUtils.rm_r project_path if (File.exists? project_path)
  end

  def analizo_hash analizo_output
    hash = {}

    analizo_output.lines.each do |line|
      if line =~ /(\S+): (~|(\d+)(\.\d+)?).*/
        hash[$1.to_sym] = $2
      end
    end

    hash
  end

  def run_analizo
    project_path = "#{RAILS_ROOT}/tmp/#{identifier}"
    raise "Missing project folder" unless File.exists? project_path
    `analizo-metrics #{project_path}`
  end

  def metrics_calculated?
    metric = Metric.find_by_project_id(id)
    return metric ? true : false
  end

end
