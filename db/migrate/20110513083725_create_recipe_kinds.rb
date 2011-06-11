class CreateRecipeKinds < ActiveRecord::Migration
  def self.up
    create_table :recipe_kinds do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_kinds
  end
end
