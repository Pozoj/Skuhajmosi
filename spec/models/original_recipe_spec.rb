require 'spec_helper'

describe OriginalRecipe do
  subject { Factory :original_recipe }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:authors_name) }
    it { should validate_presence_of(:authors_email) }
    it { should validate_presence_of(:preparation) }
    it { should validate_presence_of(:ingredients) }
    it { should validate_presence_of(:num_people) }
    it { should validate_numericality_of(:num_people) }
  end
  
  describe "relations" do
    it { should have_one(:recipe)}
  end
end
