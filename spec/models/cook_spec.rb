require 'spec_helper'

describe Cook do
  subject { Factory :cook }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :description }
  end
end
