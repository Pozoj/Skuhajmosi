class ChangeUserKindTypeToStringInAccessRights < ActiveRecord::Migration
  def self.up
    change_column :access_rights, :user_kind_id, :string
  end

  def self.down
    change_column :access_rights, :user_kind_id, :integer
  end
end