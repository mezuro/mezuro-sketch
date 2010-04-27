class ChangeMetricsValue < ActiveRecord::Migration
  def self.up
    remove_column :metrics, :value
    add_column :metrics, :value, :integer
  end

  def self.down
    remove_column :metrics, :value
    add_column :metrics, :value, :string
  end
end
