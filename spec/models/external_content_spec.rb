require 'spec_helper'

describe ExternalContent do
  subject { Factory :external_content }
  
  it { should be_valid }
  it { should belong_to :external_content_kind }
  it { should belong_to :author }
  it { should validate_presence_of :title }
end
