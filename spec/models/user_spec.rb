require 'spec_helper'

describe User do
  subject { Factory :user }
  
  describe "validations" do    
    it { should be_valid }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_format_of(:email).with( /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i) }
  end
  
  it "should return name when to_s is called" do
    subject.to_s.should == "#{subject.first_name} #{subject.last_name}"
  end
  
  it "should return users access rights" do
    access_right = Factory :access_right
    subject.access_rights.first.should == access_right
  end
  
  it "should have given rights" do
    access_right = Factory :access_right
    Ability.new(subject).can?(:manage, Recipe).should == true
  end
end
