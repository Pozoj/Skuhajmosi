require 'spec_helper'

describe RecipeAuthor do
  subject { Factory :recipe_author}
  
  it { should be_valid }
  it { should have_many :recipe_sources }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many :photos }
end
