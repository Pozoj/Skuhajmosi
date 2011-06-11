class CreateRecipeSources < ActiveRecord::Migration
  def self.up
    create_table :recipe_sources do |t|
      t.references :recipe
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_sources
  end
end
