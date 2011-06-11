require 'spec_helper'

describe VendorsProduct do
  subject { Factory :vendors_product }
  
  it { should be_valid }
  it { should belong_to :vendor }
  it { should belong_to :product }
  it { should validate_numericality_of :price }
end
