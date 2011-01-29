class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :name
      t.integer :calories
      t.integer :num_people
      t.text :abstract
      t.text :description
      t.text :preparation
      t.boolean :vegeterian
      t.boolean :dietetic
      t.integer :time_to_prepare
      t.integer :time_to_cook
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
