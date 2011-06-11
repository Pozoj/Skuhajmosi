require 'spec_helper'

describe Product do
  subject { Factory :product }
  
  it { should be_valid }
  it { should belong_to :product_firm  }
  it { should belong_to :ingredient }
  it { should belong_to :unit }
  it { should have_many :photos  }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :product_firm }
  it { should validate_presence_of :ingredient }
end
