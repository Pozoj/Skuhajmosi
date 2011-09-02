require 'spec_helper'

describe Nostalgic do
  subject { Factory :nostalgic }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
  end
  
  describe "associations" do
    it { should have_many(:photos) }
  end
  
end
