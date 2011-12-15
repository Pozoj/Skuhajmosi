class Product < ActiveRecord::Base
  belongs_to :product_firm
  belongs_to :ingredient
  belongs_to :unit
  has_many :photos, :as => :holder, :dependent => :destroy
  has_many :vendors_products
  has_many :vendors, :through => :vendors_products
  
  validates_presence_of :name
  validates_presence_of :product_firm_id
  validates_presence_of :ingredient_id
  
  default_scope order("name ASC")
  
  def quantity_title
    unit.short_name.present? ? quantity.to_s + " " + unit.short_name : quantity.to_s + " " + unit.name
  end
  
  def to_s
    name
  end
end
