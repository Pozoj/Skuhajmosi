class CreateNostalgia < ActiveRecord::Migration
  def self.up
    create_table :nostalgia do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :nostalgia
  end
end
