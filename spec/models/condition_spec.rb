require 'spec_helper'

describe Condition do
  subject { Factory :condition }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :content }
  end
  
end
