class CreateRecipeAuthors < ActiveRecord::Migration
  def self.up
    create_table :recipe_authors do |t|
      t.references :recipe_source
      t.string :first_name
      t.string :last_name
      t.text :about

      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_authors
  end
end
