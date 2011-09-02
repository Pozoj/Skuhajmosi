require 'spec_helper'

describe TableCover do
  subject { Factory :table_cover }
  
  describe "validations" do
   it { should be_valid }
   it { should validate_presence_of :title }
   it { should validate_presence_of :content }
  end

  describe "associations" do
   it { should have_many(:photos) }
  end
end
