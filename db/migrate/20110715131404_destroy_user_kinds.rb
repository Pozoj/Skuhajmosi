class DestroyUserKinds < ActiveRecord::Migration
  def self.up
    drop_table :user_kinds
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted user kinds"
  end
end
