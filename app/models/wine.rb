class Wine < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :wine_group
  belongs_to :wine_kind
  belongs_to :wine_color
  
  has_many :recipe_wines
  has_many :recipes, :through => :recipe_wines
  has_many :photos, :as => :holder
  
  validate :association_dependencies
  validates_presence_of :description
  
  def to_s
    "#{wine_color} #{wine_kind.to_s.downcase} #{wine_group.to_s.downcase} vino"
  end

  private
  
  def association_dependencies
    message = "mora biti izbrana"
    errors.add :wine_group, message if wine_group.nil?
    errors.add :wine_kind,  message if wine_kind.nil?
    errors.add :wine_color, message if wine_color.nil?
    errors.add :author,     "Niste prijavljeni" if author.nil?
  end
end
