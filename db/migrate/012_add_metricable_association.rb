class AddMetricableAssociation < ActiveRecord::Migration
  def self.up
    remove_column :metrics, :project_id
    add_column :metrics, :metricable_id, :integer
    add_column :metrics, :metricable_type, :string
  end

  def self.down
    remove_column :metrics, :metricable_type, :string
    remove_column :metrics, :metricable_id, :integer
    add_column :metrics, :project_id
  end
end
