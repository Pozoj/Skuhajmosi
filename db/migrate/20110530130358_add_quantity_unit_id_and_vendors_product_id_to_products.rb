class AddQuantityUnitIdAndVendorsProductIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :quantity, :decimal, :precision => 8, :scale => 2, :default => 0.0
    add_column :products, :unit_id, :integer
    add_column :products, :product_code, :string
  end

  def self.down
    remove_column :products, :quantity
    remove_column :products, :unit_id
    remove_column :products, :product_code
  end
end
