require 'spec_helper'

describe WineGroup do
  subject { Factory :wine_group }
  
  it { should have_many :wines }
  it { should be_valid }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
end
