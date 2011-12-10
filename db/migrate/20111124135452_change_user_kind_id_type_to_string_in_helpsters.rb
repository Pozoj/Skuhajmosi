class ChangeUserKindIdTypeToStringInHelpsters < ActiveRecord::Migration
  def up
    change_column(:helpsters, :user_kind_id, :string)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
