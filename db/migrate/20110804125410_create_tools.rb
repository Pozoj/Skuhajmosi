class CreateTools < ActiveRecord::Migration
  def self.up
    create_table :tools do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :tools
  end
end
