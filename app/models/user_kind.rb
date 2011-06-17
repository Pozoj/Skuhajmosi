class UserKind < ActiveRecord::Base
  has_many :users
  has_many :access_rights
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  EXTERNAL_AUTHOR_KIND_NAME = "Zunanji"
  
  class << self
    def kinds
      self.all.collect {|uk| uk.to_sym }
    end
    
    def external_author_user_kind
      self.find_by_name(EXTERNAL_AUTHOR_KIND_NAME)
    end
  end
  
  def to_s
    name
  end
  
  def to_sym
    name.to_permalink.sub('-','_').to_sym
  end
end
