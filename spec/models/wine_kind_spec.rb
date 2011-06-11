require 'spec_helper'

describe WineKind do
  subject { Factory :wine_kind }
  
  it { should have_many :wines }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  
  
  it { should be_valid }
end
