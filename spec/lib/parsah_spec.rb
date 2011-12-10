require 'spec_helper'
require 'rexml/document'

describe Parsah do
  describe ".parse" do
    before do
      @parsed = Parsah.parse("/Users/ljubo/Sites/skuhajmo/spec/presets/prices.xml")
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
    it "should check if 'products' is the root"
    it "should check if all entries are 'product'"
    it "should check if all entries in 'product' are present (ingredient_id, product_code, product_name, preferred, deal_description, product_price, product_quantity)"
    it "should check if ingredient_id is an integer"
    it "should check if preferred is a 1 or a 0"
    it "should check if product price is a valid noumber"
    it "should check if product quantity is a valid number"
  end
  
  describe ".workit" do
    it "should check if xml is valid"
    
    describe "with valid xml" do
      it "should shold drop the base (Product, ProductFirm, VendorsProduct) if xml is valid"
      it "should create Product, ProductFirm and VendorsProduct entries from parsed Parsah instances"
    end
    
    describe "with invalid xml" do
      it "shouldn't drop the base if xml is invalid"
    end
  end
  
end
