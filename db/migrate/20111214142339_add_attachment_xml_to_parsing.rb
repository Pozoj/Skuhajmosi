class AddAttachmentXmlToParsing < ActiveRecord::Migration
  def change
    create_table  :parsings do |t|
      t.string    :xml_file_name
      t.string    :xml_content_type
      t.integer   :xml_file_size
      t.datetime  :xml_updated_at
    end
  end
end
