class CreateEkos < ActiveRecord::Migration
  def self.up
    create_table :ekos do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :ekos
  end
end
