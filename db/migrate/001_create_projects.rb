class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :repository_url

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
