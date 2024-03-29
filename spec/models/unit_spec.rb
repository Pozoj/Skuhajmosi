require 'spec_helper'

describe Unit do
  subject { Factory :unit }
  
  it { should be_valid }
  it { should validate_presence_of(:name) }
  
  it "should not validate presence of denominator when the unit is not convertable" do
    u = Factory :unit, :convertable => false
    u.should_not validate_presence_of :denominator
  end
  
  it "should not validate denominators numericallity when the unit is not convertable" do
    u = Factory :unit, :convertable => false
    u.should_not validate_numericality_of :denominator
  end

  it "should validate presence of denominator when the unit is convertable" do
    unit = Factory :unit, :convertable => true
    unit.should validate_presence_of(:denominator)
  end
  
  it "should validate numericallity of denominator when the unit is convertable" do
    unit = Factory :unit, :convertable => true
    unit.should validate_numericality_of :denominator
  end
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
end
