class VendorsProduct < ActiveRecord::Base
  
  belongs_to :vendor
  belongs_to :product
  
  validates_numericality_of :price, :greater_than => 0
end
