class AddTestPriceAndWeightToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :price_for_weight_in_grams, :decimal, :precision => 8, :scale => 2, :default => 0.0
    add_column :ingredients, :weight_in_grams, :decimal, :precision => 10, :scale => 5, :default => 0.0
  end

  def self.down
    remove_column :ingredients, :price_for_weight_in_grams
    remove_column :ingredients, :weight_in_grams
  end
end
