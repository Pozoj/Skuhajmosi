class CreateExternalContents < ActiveRecord::Migration
  def self.up
    create_table :external_contents do |t|
      t.references :external_content_kind
      t.references :author
      t.string :title
      t.text :content
      t.string :url_title
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :external_contents
  end
end
