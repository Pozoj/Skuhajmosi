class CreateHealthies < ActiveRecord::Migration
  def self.up
    create_table :healthies do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :healthies
  end
end
