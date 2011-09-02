require 'spec_helper'

describe RecipeSourceKind do
  subject { Factory :recipe_source_kind }
  
  it { should be_valid }
  
  it { should have_many :recipe_sources }
  it { should have_many(:recipe_authors).through(:recipe_sources) }
  it { should have_many :photos }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
