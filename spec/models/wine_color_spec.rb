require 'spec_helper'

describe WineColor do
  subject { Factory :wine_color }
  
  it { should have_many :wines }
  it { should be_valid }  
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
end
