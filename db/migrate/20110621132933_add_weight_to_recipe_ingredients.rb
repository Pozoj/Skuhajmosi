class AddWeightToRecipeIngredients < ActiveRecord::Migration
  def self.up
    add_column :recipe_ingredients, :weight_in_grams, :decimal, :precision => 10, :scale => 5, :default => 0.0
  end

  def self.down
    remove_column :recipe_ingredients, :weight_in_grams
  end
end
