class Parsing < ActiveRecord::Base
  has_attached_file :xml, :url => "/system/parsings/:id/:basename.:extension"
end