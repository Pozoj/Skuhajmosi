require 'spec_helper'

describe RecipeWine do
  subject { Factory :recipe_wine }
  
  it { should belong_to :wine }
  it { should belong_to :recipe }
  
  it { should be_valid }
end
