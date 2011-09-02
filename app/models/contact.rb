class Contact < ActiveRecord::Base
  validates_presence_of :name, :address, :tax_nr, :telephone, :fax, :mobile, :email, :website, :notes
end
