class CreateRecipeIngredients < ActiveRecord::Migration
  def self.up
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.integer :unit_id
      t.decimal :quantity, :precision => 8, :scale => 2, :default => 0.0
      t.string  :quantity_description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_ingredients
  end
end
