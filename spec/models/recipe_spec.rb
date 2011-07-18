require 'spec_helper'

describe Recipe do
  subject { Factory :recipe }
  
  it { should be_valid }

  it { should have_one :recipe_source }
  it { should have_many :ingredients  }
  it { should have_many :recipe_ingredients }
  it { should have_many :photos }
  it { should have_and_belong_to_many :recipe_kinds }
  it { should have_many :recipe_wines }
  it { should have_many(:wines).through(:recipe_wines) }
  
  it { should validate_presence_of :name  }
  it { should validate_numericality_of :num_people }
  it { should validate_numericality_of :time_to_prepare }
  it { should validate_numericality_of :time_to_cook }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
  it "should return an array with the given recipe" do
    recipe = Factory :recipe, :num_people => 4
    Recipe.by_nr_of_people(4).should == [[recipe], "Našli smo 1 recept."]
  end
  
  it "should return correct calculation of calories" do
    recipe = Factory :recipe
    ingredient = Factory :ingredient, :calories => BigDecimal("100")
    gram = Factory :unit, :name => "Gram", :denominator => 1000
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 1, :unit => gram)
    #100 calories_per_100_g /100 * (1 / 1000)kg = 0.001 kcal
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 2, :unit => gram)
    #100 calories_per_100_g /100 * (2 / 1000)kg = 0.002 kcal
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 3, :unit => gram)
    #100 calories_per_100_g /100 * (3 / 1000)kg = 0.003 kcal
    #-------------------------------------------------------
    #                       total kilo calories = 0.006 kcal
    #                                num_people = 4
    #-------------------------------------------------------
    #                                 0.006 / 4 = 0.0015
    recipe.number_of_kcal_per_meal.should == BigDecimal("0.0015")
  end


  it "should return correct calculation of calories" do
    recipe = Factory :recipe
    ingredient = Factory :ingredient, :calories => BigDecimal("100")
    gram = Factory :unit, :name => "Gram", :denominator => 1000
    dekagram = Factory :unit, :name => "Gram", :denominator => 100
    kilogram = Factory :unit, :name => "Gram", :denominator => 1
    
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 1, :unit => gram)
    #100 calories_per_100_g /100 * (1 / 1000)kg = 0.001 kcal
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 2, :unit => dekagram)
    #100 calories_per_100_g /100 * (2 / 100)kg = 0.02 kcal
    recipe.recipe_ingredients << Factory(:recipe_ingredient, :recipe => recipe, :ingredient => ingredient, :quantity => 2, :unit => kilogram)
    #100 calories_per_100_g /100 * 2kg         = 2 kcal
    #-------------------------------------------------------
    #                      total kilo calories = 2.021 kcal
    #                               num_people = 4
    #-------------------------------------------------------
    #                                2.021 / 4 = 0.50525
    recipe.number_of_kcal_per_meal.should == BigDecimal("0.50525")
  end
    
end
