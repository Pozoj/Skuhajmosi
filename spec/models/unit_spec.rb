require 'spec_helper'

describe Unit do
  subject { Factory :unit }
  
  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:denominator) }
end
