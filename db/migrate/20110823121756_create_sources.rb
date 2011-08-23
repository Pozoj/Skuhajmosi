class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.integer :recipe_source_id
      t.integer :recipe_id
      t.timestamps
    end
    
    remove_column :recipe_sources, :recipe_id
  end

  def self.down
    add_column :recipe_sources, :recipe_id, :integer
    drop_table :sources
  end
end
