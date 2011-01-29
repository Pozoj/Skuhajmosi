require 'spec_helper'

describe Recipe do
  subject { Factory :recipe }
  
  it { should be_valid }
  it { should have_many(:ingredients) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
end
