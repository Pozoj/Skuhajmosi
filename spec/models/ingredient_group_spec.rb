require 'spec_helper'

describe IngredientGroup do
  subject { Factory :ingredient_group }
  
  it { should be_valid }
  it { should validate_presence_of(:name) }
end
