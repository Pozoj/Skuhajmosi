require 'spec_helper'

describe Vendor do
  subject { Factory :vendor }
  
  it { should be_valid }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
end
