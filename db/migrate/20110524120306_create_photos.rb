class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :holder_id
      t.string  :holder_type
      
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.string  :photo_file_size
      t.string  :photo_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
