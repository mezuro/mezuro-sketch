class AddingProjectsFields < ActiveRecord::Migration
  def self.up
    add_column :projects, :identifier, :string
    add_column :projects, :personal_webpage, :string
  end

  def self.down
    remove_column :projects, :identifier
    remove_column :projects, :personal_webpage
  end
end
