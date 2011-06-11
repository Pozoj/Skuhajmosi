class CreateWineGroups < ActiveRecord::Migration
  def self.up
    create_table :wine_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :wine_groups
  end
end
