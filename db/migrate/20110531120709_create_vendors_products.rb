class CreateVendorsProducts < ActiveRecord::Migration
  def self.up
    create_table :vendors_products do |t|
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0
      t.references :vendor
      t.references :product

      t.timestamps
    end
  end

  def self.down
    drop_table :vendors_products
  end
end
