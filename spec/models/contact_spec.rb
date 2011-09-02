require 'spec_helper'

describe Contact do
  subject { Factory :contact }
  
  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :tax_nr }
    it { should validate_presence_of :fax }
    it { should validate_presence_of :mobile }
    it { should validate_presence_of :email }
    it { should validate_presence_of :website }
    it { should validate_presence_of :notes }
  end
end
