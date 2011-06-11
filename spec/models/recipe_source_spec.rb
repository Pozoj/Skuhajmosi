require 'spec_helper'

describe RecipeSource do
  subject { Factory :recipe_source }
  
  it { should be_valid }
  it { should belong_to :recipe }
  it { should have_many :recipe_authors }
  it { should validate_presence_of :title }
  it { should have_many :photos }
end
