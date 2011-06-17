class Vendor < ActiveRecord::Base
  has_many :vendors_products
  has_many :products, :through => :vendors_products
  
  default_scope order("name ASC")
  
  def to_s
    name
  end
end
