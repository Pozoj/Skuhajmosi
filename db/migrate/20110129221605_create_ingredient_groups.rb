class CreateIngredientGroups < ActiveRecord::Migration
  def self.up
    create_table :ingredient_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredient_groups
  end
end
