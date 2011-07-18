class CreateOriginalRecipes < ActiveRecord::Migration
  def self.up
    create_table :original_recipes do |t|
      t.string :authors_name
      t.string :authors_email
      t.string :name
      t.integer :num_people
      t.text :summary
      t.text :preparation
      t.text :suggestion
      t.text :ingredients
      t.string :time_to_cook
      t.string :time_to_prepare

      t.timestamps
    end
  end

  def self.down
    drop_table :original_recipes
  end
end
