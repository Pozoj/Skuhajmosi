class Nostalgic < ActiveRecord::Base
  set_table_name "nostalgia"
  has_many :photos, :as => :holder, :dependent => :destroy
end
