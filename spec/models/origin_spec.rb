require 'spec_helper'

describe Origin do
  subject { Factory :origin }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of(:recipe_id).with_message("Mora biti izbran.")}
    it { should validate_presence_of(:recipe_source_id).with_message("Mora biti izbran.")}
  end
  
  describe "associations" do
    it { should belong_to :recipe }
    it { should belong_to :recipe_source }
  end
end
