require 'spec_helper'

describe IngredientGroup do
  subject { Factory :ingredient_group }
  
  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should have_and_belong_to_many(:ingredients) }
end
