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
  
  it "should return ingredient when to_s is called" do
    subject.to_s.should == subject.ingredient
  end
  
  it "should return ingredient and proper string when info is called" do
    subject.info.should == [subject.ingredient, ": #{subject.quantity} #{subject.unit.short_name}"]
  end
  
  it "should calculate corret conversion of kilograms to grams" do
    kilogram = Factory :unit, :name => "Kilogram", :denominator => 1
    recipe_ingredient = Factory :recipe_ingredient, :quantity => 1, :unit => kilogram
    recipe_ingredient.calculated_weight_in_grams.should == 1000
  end

  it "should calculate corret conversion of dekagrams to grams" do
    dekagram = Factory :unit, :name => "Dekagram", :denominator => 100
    recipe_ingredient = Factory :recipe_ingredient, :quantity => 1, :unit => dekagram
    recipe_ingredient.calculated_weight_in_grams.should == 10
  end
  
  it "should calculate corret conversion of grams to grams" do
    gram = Factory :unit, :name => "Gram", :denominator => 1000
    recipe_ingredient = Factory :recipe_ingredient, :quantity => 1, :unit => gram
    recipe_ingredient.calculated_weight_in_grams.should == 1
  end
  
  
end
