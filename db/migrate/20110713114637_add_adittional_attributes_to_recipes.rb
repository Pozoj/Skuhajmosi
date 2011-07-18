class AddAdittionalAttributesToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :short_name, :string
    add_column :recipes, :memo, :text
  end

  def self.down
    remove_column :recipes, :memo
    remove_column :recipes, :short_name
  end
end
