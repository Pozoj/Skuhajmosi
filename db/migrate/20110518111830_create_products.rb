class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.integer :ingredient_id
      t.integer :product_firm_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
