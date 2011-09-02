require 'spec_helper'

describe About do
  subject { Factory :about }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of      :content  }
  end
end
