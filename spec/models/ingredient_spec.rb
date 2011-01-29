require 'spec_helper'

describe Ingredient do
  subject { Factory :ingredient }
  
  it { should be_valid }
  it { should belong_to(:product) }
  it { should have_many(:ingredient_groups) }
  it { should have_many(:recipe_ingredient) }
  it { should have_many(:recipes) }
  it { should validate_presence_of(:name) }
  
end
