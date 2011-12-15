class Parsah
  attr_accessor :doc
  attr_reader :ingredient_id, :product_code, :product_firm_name, :product_name, :preferred, :deal_description, :product_price, :product_quantity
  ELEMENT_NAMES = %w[ ingredient_id product_code product_firm_name product_name preferred deal_description product_price product_quantity ]
  VENDOR_NAME = "Tuš"

  def initialize(_ingredient_id = nil, _product_code = nil, _product_firm_name = nil, _product_name = nil, _preferred = nil, _deal_description = nil, _product_price = nil, _product_quantity = nil)
    @ingredient_id, @product_code, @product_firm_name, @product_name, @preferred, @deal_description, @product_price, @product_quantity = _ingredient_id, _product_code, _product_firm_name, _product_name, _preferred, _deal_description, _product_price, _product_quantity
  end
  
  class << self
    def workit(xml_file)
      parsah = Parsah.load_xml(xml_file)
      parsed_collection = parsah.parse if parsah.validity_check
      if parsed_collection.present? and parsed_collection.any?
        [ProductFirm, Product, VendorsProduct].each {|klass| klass.destroy_all}
        parsed_collection.each do |instance|
          product_firm, product, vendor, unit_id = nil, nil, nil, Unit.find_or_create_by_name_and_short_name_and_denominator_and_convertable("gram", "g", 1000, true).id
          if product_firm = ProductFirm.find_or_create_by_name(instance.product_firm_name)
            if product = Product.find_or_create_by_product_firm_id_and_ingredient_id_and_name_and_preferred_and_deal_description_and_product_code_and_quantity_and_unit_id(product_firm.id, instance.ingredient_id, instance.product_name, instance.preferred, instance.deal_description, instance.product_code, instance.product_quantity, unit_id)
              #To be changed if single vendor strategy fails!
              vendor = Vendor.any? ? vendor = Vendor.first : Vendor.create(:name => VENDOR_NAME)
              VendorsProduct.create( :vendor_id => vendor.id, :product_id => product.id, :price => instance.product_price)
            end
          end
        end
        return true
      end
      return false
    end

    def load_xml(xml_file)
      parsah = Parsah.new
      parsah.doc = REXML::Document.new(File.new(xml_file))
      parsah
    end
    
    def parse(xml_file)
      parsah = Parsah.load_xml(xml_file)
      parsah.parse
    end
    
    def validity_check(xml_file)
      parsah = Parsah.load_xml(xml_file)
      parsah.validity_check
    end
  end #class << self

  def validity_check
    if valid_root and valid_children and valid_grandchildren then true else false end
  end
  
  def parse
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

  def is_a_number?(s)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true 
  end
    
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
        #proper element name check
        return false unless ELEMENT_NAMES.include?(element.name)
        #proper ingredient_id value check
        if element.name == "ingredient_id"
          begin
            Integer(element.text)
          rescue
            return false
          end
        end
        #proper preferred value check
        if element.name == "preferred"
          return false unless ["0", "1"].include?(element.text)
        end
        #price and quantity number check
        if element.name == "product_price" or element.name == "product_quantity"
          return false if is_a_number?(element.text) == false
        end
      end
    end
    return true    
  end  

end