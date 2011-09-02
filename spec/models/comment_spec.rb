require 'spec_helper'

describe Comment do
  subject { Factory :comment }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :name }
    it { should validate_presence_of :content }
  end
  
end
