class Event < ActiveRecord::Base
  has_many :photos, :as => :holder, :dependent => :destroy
end
