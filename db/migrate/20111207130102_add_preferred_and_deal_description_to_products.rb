class AddPreferredAndDealDescriptionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :preferred, :boolean, :default => false
    add_column :products, :deal_description, :text
  end
end
