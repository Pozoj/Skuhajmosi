class Cook < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :description
  has_many :photos, :as => :holder, :dependent => :destroy
  
  def to_s
    "#{first_name} #{last_name}"
  end
end
