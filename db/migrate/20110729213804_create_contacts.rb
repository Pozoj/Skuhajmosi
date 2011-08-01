class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :tax_nr
      t.string :telephone
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :website
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
