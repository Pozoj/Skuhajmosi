require 'spec_helper'

describe Event do
  subject { Factory :event }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :location }
    it { should validate_presence_of :starting_at }
  end
  
  describe "associations" do
    it { should have_many :photos }
  end
end
