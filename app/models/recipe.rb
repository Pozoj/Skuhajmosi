class Recipe < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_one :recipe_source
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  has_and_belongs_to_many :recipe_kinds
  has_many :recipe_wines
  has_many :wines, :through => :recipe_wines
  
  validates_presence_of :name, :author
  validates_numericality_of :num_people, :greater_than_or_equal_to => 1, :only_integer => true, :if => Proc.new { |recipe| not recipe.num_people.nil? }
  validates_numericality_of :time_to_prepare, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_prepare.nil? }
  validates_numericality_of :time_to_cook, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_cook.nil? }
  
  class << self
    def by_nr_of_people(nr_of_people)
      where(:num_people => nr_of_people)
    end
  end
  
  def to_s
    name
  end
end
