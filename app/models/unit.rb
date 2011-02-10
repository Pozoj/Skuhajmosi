class Unit < ActiveRecord::Base
  validates_presence_of :denominator
  validates_presence_of :name
  
  def to_s
    name
  end
end
