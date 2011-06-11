class CreateExternalContentKinds < ActiveRecord::Migration
  def self.up
    create_table :external_content_kinds do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :external_content_kinds
  end
end
