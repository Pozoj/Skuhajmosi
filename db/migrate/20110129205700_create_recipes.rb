class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :author_id
      t.string :name
      t.integer :num_people
      t.text :summary
      t.text :preparation
      t.text :suggestion
      t.integer :time_to_prepare
      t.integer :time_to_cook

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
