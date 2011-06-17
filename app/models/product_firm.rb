class ProductFirm < ActiveRecord::Base
  has_many :products
  
  validates_presence_of :name
  
  default_scope order("name ASC")
  
  def to_s
    name
  end
end
