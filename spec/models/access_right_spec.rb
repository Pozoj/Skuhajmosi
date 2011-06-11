require 'spec_helper'

describe AccessRight do
  subject { Factory :access_right }
  
  it { should be_valid }  
  it { should belong_to(:user_kind) }
end
