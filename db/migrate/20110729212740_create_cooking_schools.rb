class CreateCookingSchools < ActiveRecord::Migration
  def self.up
    create_table :cooking_schools do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :cooking_schools
  end
end
