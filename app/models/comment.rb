class Comment < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :content
  
  def to_s
    name
  end
end
