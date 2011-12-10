class CreateHelpsters < ActiveRecord::Migration
  def change
    create_table :helpsters do |t|
      t.string :container_id
      t.integer :user_kind_id
      t.text :help

      t.timestamps
    end
  end
end
