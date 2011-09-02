class TableCover < ActiveRecord::Base
  has_many :photos, :as => :holder, :dependent => :destroy
  validates_presence_of :title, :content
end
