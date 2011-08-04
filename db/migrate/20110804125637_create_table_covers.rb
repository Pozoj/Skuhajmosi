class CreateTableCovers < ActiveRecord::Migration
  def self.up
    create_table :table_covers do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :table_covers
  end
end
