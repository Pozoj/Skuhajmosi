class ChangeUserKindTypeToStringInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :user_kind_id, :string
  end

  def self.down
    change_column :users, :user_kind_id, :integer
  end
end