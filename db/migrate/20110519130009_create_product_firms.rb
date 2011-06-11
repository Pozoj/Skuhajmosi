class CreateProductFirms < ActiveRecord::Migration
  def self.up
    create_table :product_firms do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :product_firms
  end
end
