class ChangeKindIdToUserKindIdInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :kind_id, :user_kind_id
  end

  def self.down
    rename_column :users, :user_kind_id, :kind_id
  end
end
