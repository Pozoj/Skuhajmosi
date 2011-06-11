require 'spec_helper'

describe UserKind do
  subject { Factory :user_kind }
  
  it { should be_valid }
  it { should have_many :users }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  
end
