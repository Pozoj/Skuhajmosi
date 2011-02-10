class CreateIngredientsIngredientGroupsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :ingredient_groups_ingredients, :force => true, :id => false do |t|
      t.integer :ingredient_id
      t.integer :ingredient_group_id
    end
  end

  def self.down
    drop_table :ingredient_groups_ingredients
  end
end