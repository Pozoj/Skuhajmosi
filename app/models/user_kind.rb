class UserKind < ActiveRecord::Base
  has_many :users, :foreign_key => "kind_id"
  validates_presence_of :name
end
