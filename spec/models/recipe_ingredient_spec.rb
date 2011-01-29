require 'spec_helper'

describe RecipeIngredient do
  subject { Factory :recipe_ingredient }
  
  it { should be_valid }
  it { should belong_to(:recipe) }
  it { should belong_to(:ingredient) }
  it { should belong_to(:quantity_unit) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:quantity_unit) }
  
  
end
