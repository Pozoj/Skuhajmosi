class TableCover < ActiveRecord::Base
  has_many :photos, :as => :holder, :dependent => :destroy
end
