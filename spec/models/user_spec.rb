require 'spec_helper'
require 'PP'

describe User do
  subject { Factory :user }
  
  it { should be_valid }
  it { should belong_to :user_kind }
  it { should have_many :recipes }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_format_of(:email).with( /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i) }
  
  
  it "should return name when to_s is called" do
    subject.to_s.should == "#{subject.first_name} #{subject.last_name}"
  end
  
  it "should return users access rights" do
    subject.access_rights.should == AccessRight.where("user_kind_id = ?", subject.user_kind.id)
  end
  
  it "should have given rights" do
    access_right = Factory :access_right, :user_kind => subject.user_kind
    Ability.new(subject).can?(:manage, Recipe).should == true
  end
end
