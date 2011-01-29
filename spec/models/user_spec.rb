require 'spec_helper'

describe User do
  subject { Factory :user }
  
  it { should be_valid }
  it { should belong_to(:kind) }
  it { should have_many(:recipes) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
end
