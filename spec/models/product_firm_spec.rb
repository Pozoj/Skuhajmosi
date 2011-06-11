require 'spec_helper'

describe ProductFirm do
  subject { Factory :product_firm }
  
  it { should be_valid }
  it { should have_many :products }
end
