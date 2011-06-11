class CreateRecipeWines < ActiveRecord::Migration
  def self.up
    create_table :recipe_wines do |t|
      t.references :recipe
      t.references :wine

      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_wines
  end
end
