require 'spec_helper'

describe Photo do
  subject { Factory :photo }
  
  it { should be_valid }
end
