class ExternalContentKind < ActiveRecord::Base
  has_many :external_contents
  
  validates_presence_of :name
  
  def to_s
    name
  end
end
