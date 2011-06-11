require 'spec_helper'

describe RecipeIngredient do
  subject { Factory :recipe_ingredient }
  
  it { should be_valid }
  it { should belong_to :recipe }
  it { should belong_to :ingredient }
  it { should belong_to :unit }
  it { should validate_presence_of :quantity } 
  it { should validate_presence_of :recipe_id  } 
  it { should validate_presence_of :ingredient_id } 
  it { should validate_presence_of :unit_id } 
  it { should validate_numericality_of :quantity }
  it { should have_many :photos }
  
end
