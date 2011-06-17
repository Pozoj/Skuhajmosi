require 'spec_helper'

describe UserKind do
  subject { Factory :user_kind }
  
  it { should be_valid }
  it { should have_many :users }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
  it "should return proper symbol when to_sym is called" do
    subject.to_sym.should == subject.name.to_permalink.sub('-','_').to_sym
  end
  
  it "should return an array of user_kind symbols" do
    Factory :user_kind, :name => "Tajnica"
    Factory :user_kind, :name => "Mojster Bole"
    
    UserKind.kinds.should == [:tajnica, :mojster_bole]
  end
end