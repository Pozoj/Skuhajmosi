class CreateWines < ActiveRecord::Migration
  def self.up
    create_table :wines do |t|
      t.text        :description
      t.references  :author
      t.references  :wine_group
      t.references  :wine_kind
      t.references  :wine_color

      t.timestamps
    end
  end

  def self.down
    drop_table :wines
  end
end
