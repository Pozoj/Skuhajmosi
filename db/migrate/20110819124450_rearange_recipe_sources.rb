class RearangeRecipeSources < ActiveRecord::Migration
  def self.up
    add_column :recipe_sources, :recipe_source_kind_id, :integer
    add_column :recipe_sources, :recipe_author_id, :integer
    remove_column :recipe_sources, :title
    remove_column :recipe_sources, :description
    
    remove_column :recipe_authors, :recipe_source_id
    add_column :recipe_authors, :email, :string
    add_column :recipe_authors, :url, :text
    add_column :recipe_authors, :url_title, :string
    
    create_table :recipe_source_kinds, :force => true do |t|
      t.string :title
      t.text  :description
      t.text  :url
      t.string :url_title
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_source_kinds
    remove_column :recipe_authors, :url_title
    remove_column :recipe_authors, :url
    remove_column :recipe_authors, :email
    add_column :recipe_authors, :recipe_source_id, :integer
    remove_column :recipe_sources, :recipe_author_id
    remove_column :recipe_sources, :recipe_source_kind_id
    add_column :recipe_sources, :description, :text
    add_column :recipe_sources, :title, :string
  end
end