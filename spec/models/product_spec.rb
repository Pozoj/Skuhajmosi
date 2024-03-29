require 'spec_helper'

describe Product do
  subject { Factory :product }
  
  it { should be_valid }
  it { should belong_to :product_firm  }
  it { should belong_to :ingredient }
  it { should belong_to :unit }
  it { should have_many :photos  }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :product_firm_id }
  it { should validate_presence_of :ingredient_id }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
  it "should return proper quantity title" do
    subject.quantity_title.should == "56.0 g"
  end
  
  it "should have preferred and deal_description among attributes" do
    subject.attributes.include?("preferred").should be_true
    subject.attributes.include?("deal_description").should be_true
  end
  
end
