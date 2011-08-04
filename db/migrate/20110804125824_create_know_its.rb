class CreateKnowIts < ActiveRecord::Migration
  def self.up
    create_table :know_its do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :know_its
  end
end
