require 'spec_helper'

describe Vendor do
  subject { Factory :vendor }
  
  it { should be_valid }
end
