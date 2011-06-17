class AddColumnNameToExternalContents < ActiveRecord::Migration
  def self.up
    add_column :external_contents, :name, :string
  end

  def self.down
    remove_column :external_contents, :name
  end
end
