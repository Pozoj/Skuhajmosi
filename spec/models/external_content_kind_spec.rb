require 'spec_helper'

describe ExternalContentKind do
  subject { Factory :external_content_kind }
  
  it { should be_valid }
  it { should have_many :external_contents }
  it { should validate_presence_of :name }
end
