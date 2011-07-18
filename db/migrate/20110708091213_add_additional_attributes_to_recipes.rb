class AddAdditionalAttributesToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :status_id,            :string
    add_column :recipes, :original_id,          :integer
    add_column :recipes, :original_ingredients, :text
    add_column :recipes, :type,                 :string
  end

  def self.down
    remove_column :recipes, :original_id
    remove_column :recipes, :status_id
    remove_column :recipes, :original_ingredients
    remove_column :recipes, :type
  end
end
