require 'spec_helper'

describe Recipe do
  subject { Factory :recipe }
  
  it { should be_valid }
  it { should belong_to :author }
  it { should have_one :recipe_source }
  it { should have_many :ingredients  }
  it { should have_many :recipe_ingredients }
  it { should have_many :photos }
  it { should have_and_belong_to_many :recipe_kinds }
  it { should have_many :recipe_wines }
  it { should have_many(:wines).through(:recipe_wines) }
  
  it { should validate_presence_of :name  }
  it { should validate_presence_of :author  } 
  it { should validate_numericality_of :num_people }
  it { should validate_numericality_of :time_to_prepare }
  it { should validate_numericality_of :time_to_cook }
  
  it "should return name when to_s is called" do
    subject.to_s.should == subject.name
  end
  
  it "should return an array with the given recipe" do
    recipe = Factory :recipe, :num_people => 4
    Recipe.by_nr_of_people(4).should == [recipe]
  end
    
end
