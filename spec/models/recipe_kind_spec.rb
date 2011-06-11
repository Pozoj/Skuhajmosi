require 'spec_helper'

describe RecipeKind do
  subject { Factory :recipe_kind }
  
  it { should be_valid }
  it { should have_and_belong_to_many :recipes }
  it { should have_many :photos }
end
