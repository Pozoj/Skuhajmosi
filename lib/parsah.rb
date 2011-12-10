class Parsah
  attr_accessor :doc
  attr_reader :ingredient_id, :product_code, :product_firm_name, :product_name, :preferred, :deal_description, :product_price, :product_quantity
  ELEMENT_NAMES = %w[ ingredient_id product_code product_firm_name product_name preferred deal_description product_price product_quantity ]

  def initialize(_ingredient_id = nil, _product_code = nil, _product_firm_name = nil, _product_name = nil, _preferred = nil, _deal_description = nil, _product_price = nil, _product_quantity = nil)
    @ingredient_id, @product_code, @product_firm_name, @product_name, @preferred, @deal_description, @product_price, @product_quantity = _ingredient_id, _product_code, _product_firm_name, _product_name, _preferred, _deal_description, _product_price, _product_quantity
  end
  
  class << self
    def parse(xml_file)
      @doc = REXML::Document.new(File.new(xml_file))
      product_collection = []
      @doc.root.each_element("//product") do |product|
        @ingredient_id      = product.elements["ingredient_id"].text.to_i
        @product_code       = product.elements["product_code"].text
        @product_firm_name  = product.elements["product_firm_name"].text
        @product_name       = product.elements["product_name"].text
        @preferred          = product.elements["preferred"].text == "0" ? false : true
        @deal_description   = product.elements["deal_description"].text
        @product_price      = BigDecimal(product.elements["product_price"].text)
        @product_quantity   = BigDecimal(product.elements["product_quantity"].text)
        
        product_collection << Parsah.new(@ingredient_id, @product_code, @product_firm_name, @product_name, @preferred, @deal_description, @product_price, @product_quantity)
      end
      product_collection
    end
      
    def validity_check(xml_file)
      parsah = Parsah.new
      parsah.doc = REXML::Document.new(File.new(xml_file))
      if parsah.valid_root and parsah.valid_children and parsah.valid_grandchildren then true else false end
    end
  end #class << self
    
  def valid_root
    @doc.root.name == "products"
  end
  
  def valid_children
    @doc.root.elements.each do |element|
      return false if element.name != "product"
    end
    return true
  end
  
  def valid_grandchildren
    doc.elements.to_a("//product").each do |product|
      return false if product.elements.count != 8
      return false if product.elements.to_a.uniq.count != 8
            
      product.elements.each do |element|
        return false unless ELEMENT_NAMES.include?(element.name)
      end
    end
    return true    
  end  

end