require 'spec_helper'

describe Wine do
  subject { Factory :wine }
  
  it { should be_valid }
  
  it { should validate_presence_of :wine_group }
  it { should validate_presence_of :wine_kind }
  it { should validate_presence_of :wine_color }
  it { should validate_presence_of :description }
  
end
