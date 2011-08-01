class CreateCooks < ActiveRecord::Migration
  def self.up
    create_table :cooks do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :cooks
  end
end
