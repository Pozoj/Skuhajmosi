require 'spec_helper'

describe Ingredient do
  subject { Factory :ingredient }
  
  it { should be_valid }
  it { should have_and_belong_to_many(:ingredient_groups) }
  it { should have_many(:recipe_ingredients) }
  it { should have_many(:recipes).through(:recipe_ingredients) }
  it { should validate_presence_of(:name) }
  it { should have_many(:photos)}
end
