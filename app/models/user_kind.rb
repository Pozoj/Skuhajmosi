class UserKind < ActiveRecord::Base
  has_many :users
  has_many :access_rights
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  class << self
    def kinds
      self.all.collect {|uk| uk.to_sym }
    end
  end
  
  def to_s
    name
  end
  
  def to_sym
    name.to_permalink.sub('-','_').to_sym
  end
end
