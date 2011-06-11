require 'spec_helper'

describe User do
  subject { Factory :user }
  
  it { should be_valid }
  it { should belong_to :user_kind }
  it { should have_many :recipes }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_format_of(:email).with( /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i) }
  
end
