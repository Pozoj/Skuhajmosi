require 'spec_helper'

describe ProductFirm do
  subject { Factory :product_firm }
  
  it { should be_valid }
  it { should have_many :products }
  it { should validate_presence_of :name }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
end
