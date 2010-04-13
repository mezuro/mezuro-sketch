class Project < ActiveRecord::Base
  validates_presence_of :name, :repository_url, :identifier

  validates_format_of :identifier, :with => /^[a-z0-9|\-|\.]+$/

  validates_uniqueness_of :identifier

  def metrics
    download_source_code
    output = run_analizo
    analizo_hash output
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
end
