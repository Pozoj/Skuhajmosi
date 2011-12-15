require 'spec_helper'
require 'rexml/document'

describe Parsah do
  VALID_XML_FILE = "/Users/ljubo/Sites/skuhajmo/spec/presets/prices.xml"
  INVALID_XML_FILE = "/Users/ljubo/Sites/skuhajmo/spec/presets/invalid.xml"
  INVALID_PREFERRED_XML_FILE = "/Users/ljubo/Sites/skuhajmo/spec/presets/invalid_preferred.xml"
  INVALID_NUMBERS_XML_FILE = "/Users/ljubo/Sites/skuhajmo/spec/presets/invalid_numbers.xml"
    
  describe ".parse" do
    before do
      @parsed = Parsah.parse(VALID_XML_FILE)
    end
  
    it "should parse out two products from xml" do
      @parsed.count.should eql(2)
    end
  
    it "should parse every detail correctly" do
      #Izdelek 1  => Chikitabannana
      @parsed[0].ingredient_id.should == 1
      @parsed[0].product_code.should == "123213asdf"
      @parsed[0].product_firm_name.should == "Chikitabannana"
      @parsed[0].product_name.should == "Chikitabannana banana"
      @parsed[0].preferred.should == true
      @parsed[0].deal_description.should == "Danes so banane 30% bolj poceni kot sicer."
      @parsed[0].product_price.should == BigDecimal("1.4")
      @parsed[0].product_quantity.should == BigDecimal("1000")
      #Izdelek 2 => Chikitajabuka
      @parsed[1].ingredient_id.should == 2
      @parsed[1].product_code.should == "1223213asdf"
      @parsed[1].product_firm_name.should == "Chikitajabuka"
      @parsed[1].product_name.should == "Chikitajabuka jabuka"
      @parsed[1].preferred.should == true
      @parsed[1].deal_description.should == "Danes so banane 30% bolj poceni kot sicer."
      @parsed[1].product_price.should == BigDecimal("1.5")
      @parsed[1].product_quantity.should == BigDecimal("1000")
    end
  end
  
  describe ".validity_check" do
    describe "of the xml schema" do
      before do
        @parsah = Parsah.new
        @parsah.doc = REXML::Document.new(File.new(VALID_XML_FILE))
      end
    
      it "should check if 'products' is the root" do
        @parsah.valid_root.should eql(true)
      end
    
      it "should check if all entries are 'product'" do
        @parsah.valid_children.should eql(true)
      end
    
      it "should check if all entries in 'product' are present (ingredient_id, product_code, product_name, preferred, deal_description, product_price, product_quantity)" do
        @parsah.valid_grandchildren.should eql(true)
      end      
    end
    
    describe "of the values" do
      it "should validate valid xml positively" do
        @parsah = Parsah.new
        @parsah.doc = REXML::Document.new(File.new(VALID_XML_FILE))
        @parsah.valid_grandchildren.should eql(true)
      end
      
      it "should validate invalid xml negatively" do
        @parsah = Parsah.new
        @parsah.doc = REXML::Document.new(File.new(INVALID_XML_FILE))
        @parsah.valid_grandchildren.should eql(false)
      end
    end
    
    it "should check if preferred is a 1 or a 0" do
      @parsah = Parsah.new
      @parsah.doc = REXML::Document.new(File.new(INVALID_PREFERRED_XML_FILE))
      @parsah.valid_grandchildren.should eql(false)
    end
    
    it "should check if product price and quantity have valid noumbers" do
      @parsah = Parsah.new
      @parsah.doc = REXML::Document.new(File.new(INVALID_NUMBERS_XML_FILE))
      @parsah.valid_grandchildren.should eql(false)
    end
  end
  
  describe ".workit" do
    describe "with valid xml" do
      it "should check if xml is valid" do
        Parsah.workit(VALID_XML_FILE).should == true
      end

      it "should create Product, ProductFirm and VendorsProduct entries from parsed Parsah instances" do
        
        Parsah.workit(VALID_XML_FILE)
        # puts "-----"
        # puts Product.all.inspect
        # puts ProductFirm.all.inspect
        # puts Vendor.all.inspect
        # puts VendorsProduct.all.inspect
        # puts "-----"
        
        Product.all.size.should eql(2)
        ProductFirm.all.size.should eql(2)
        VendorsProduct.all.size.should eql(2)
      end
    end
    
    describe "with invalid xml" do
      it "should check if xml is valid (negative check)" do
        Parsah.workit(INVALID_XML_FILE).should == false
      end
      
      it "shouldn't drop the base if xml is invalid" do
        pfff = ProductFirm.find_or_create_by_name("Fuckthisfirm")
        Parsah.workit(INVALID_XML_FILE)
        ProductFirm.all.include?(pfff).should eql(true)
      end
    end
  end
  
end
