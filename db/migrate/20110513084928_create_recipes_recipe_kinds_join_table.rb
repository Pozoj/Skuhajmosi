class CreateRecipesRecipeKindsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :recipe_kinds_recipes, :force => true, :id => false do |t|
      t.integer :recipe_id
      t.integer :recipe_kind_id
    end
  end

  def self.down
    drop_table :recipe_kinds_recipes
  end
end
