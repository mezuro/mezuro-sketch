class ChangeMetricsValueToFloat < ActiveRecord::Migration
  def self.up
    remove_column :metrics, :value
    add_column :metrics, :value, :float
  end

  def self.down
    remove_column :metrics, :value
    add_column :metrics, :value, :integer
  end
end
