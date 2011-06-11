class Vendor < ActiveRecord::Base
  has_many :vendors_products
  has_many :products, :through => :vendors_products
  
  def to_s
    name
  end
end
