class Project < ActiveRecord::Base
  validates_presence_of :name, :repository_url, :identifier

  validates_format_of :identifier, :with => /^[a-z0-9|\-|\.]+$/

  validates_uniqueness_of :identifier

  def metrics
    {"noa" => 4, "loc" => 10, "nom" => 2}
  end

  def analizo_hash analizo_output
    hash = {
      :acc_average => "0",
      :acc_kurtosis => "0",
      :acc_maximum => "1",
      :acc_median => "0.5",
      :acc_mininum => "0"
    }

    if analizo_output =~ /acc_average: (~|(\d+)(\.\d+)?).*/
      hash[:acc_average] = $1
    end

    hash
  end
end
