class AddSvnErrorOnProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :svn_error, :string
  end

  def self.down
    remove_column :projects, :svn_error
  end
end
