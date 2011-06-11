class WineColor < ActiveRecord::Base
  has_many :wines

  validates_presence_of :name
  validates_presence_of :description

  def to_s
    name
  end
end
