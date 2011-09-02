require 'spec_helper'

describe RecipeSource do
  subject { Factory :recipe_source }
  
  it { should be_valid }
  it { should belong_to :recipe_source_kind }
  it { should belong_to :recipe_author }  
  it { should have_many :origins }
  it { should validate_presence_of(:recipe_source_kind_id).with_message("Mora biti izbrano.") }
  it { should validate_presence_of(:recipe_author_id).with_message("Mora biti izbrano.") }
end
