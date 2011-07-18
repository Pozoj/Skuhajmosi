class AddDescriptionToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :description, :text
  end

  def self.down
    remove_column :ingredients, :description
  end
end
