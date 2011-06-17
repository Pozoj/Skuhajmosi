require 'spec_helper'

describe Wine do
  subject { Factory :wine }
  
  it { should be_valid }
  
  it { should validate_presence_of :description }
  
  it { should validate_presence_of(:wine_group).with_message("mora biti izbrana") }
  it { should validate_presence_of(:wine_kind).with_message("mora biti izbrana") }
  it { should validate_presence_of(:wine_color).with_message("mora biti izbrana") }
  
  
  it "should return name when to_s is called" do
    subject.to_s.should == "#{subject.wine_color} #{subject.wine_kind.to_s.downcase} #{subject.wine_group.to_s.downcase} vino"
  end
end
