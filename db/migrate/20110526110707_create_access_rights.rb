class CreateAccessRights < ActiveRecord::Migration
  def self.up
    create_table :access_rights do |t|
      t.integer :user_kind_id 
      t.string  :name
      t.string  :right

      t.timestamps
    end
  end

  def self.down
    drop_table :access_rights
  end
end
