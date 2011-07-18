class OriginalRecipe < ActiveRecord::Base
  has_one :recipe, :foreign_key => "original_id"
  has_many :photos, :as => :holder, :dependent => :destroy
  
  validates_presence_of :authors_name
  validates_presence_of :authors_email
  validates_presence_of :name
  validates_presence_of :preparation
  validates_presence_of :ingredients
  validates_presence_of :num_people
  validates_numericality_of :num_people, :only_integer => true
  validates_format_of :authors_email, :with => Configuration::EMAIL_CHECK
  
  accepts_nested_attributes_for :photos
  
  
  class << self
    
    # Displays all user entered recipes that had not jet been treated
    #
    def untreated
      joins("LEFT JOIN recipes ON original_recipes.id = recipes.original_id").where("recipes.id IS NULL").order("created_at DESC")
      #all - self.find(Recipe.original_ids)
    end
    
  end # class << self
  
  def to_s
    name.capitalize
  end
  
end
