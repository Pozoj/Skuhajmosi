require 'spec_helper'

describe Ingredient do
  subject { Factory :ingredient }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:calories)}
    it { should validate_numericality_of(:calories)}
  end
  
  describe "associations" do
    it { should have_and_belong_to_many(:ingredient_groups) }
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:recipes).through(:recipe_ingredients) }
    it { should have_many(:photos) }    
  end
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
  it "should respond to description" do
    subject.should respond_to(:description)
  end
end
