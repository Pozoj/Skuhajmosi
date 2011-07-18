class RemoveUnnecessaryColumnsFromRecipes < ActiveRecord::Migration
  def self.up
    remove_column :recipes, :author_id
    remove_column :recipes, :original_ingredients
    remove_column :recipes, :type
  end

  def self.down
    add_column :recipes, :type, :string
    add_column :recipes, :original_ingredients, :text
    add_column :recipes, :author_id, :integer
  end
end
