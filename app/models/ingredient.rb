class Ingredient < ActiveRecord::Base
  has_many :products
  has_many :recipe_ingredients
  has_many :recipes, :through => :recipe_ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  has_and_belongs_to_many :ingredient_groups  
  
  validates_presence_of :name, :price_for_weight_in_grams, :weight_in_grams
  validates_presence_of :calories
  validates_numericality_of :calories
  validates_numericality_of :price_for_weight_in_grams, :weight_in_grams, :greater_than => 0
    
  default_scope order("name ASC")
  
  FAIL_SEARCH_MESSAGE = "Žal iskane sestavine ne moremo najti. Na voljo so slednje sestavine."
  NOTHING_ENTERED_MESSAGE = "Kaj iščete? Na voljo so slednje sestavine."
  
  class << self
    def search(params)
      query = params[:search][:ingredient] if params[:search][:ingredient]
      if query 
        ingredient_query = self.where("name LIKE ?", "%#{query}%")
        if ingredient_query.any?
          count = ingredient_query.length
          return [ ingredient_query, self.build_message(count) ]
        else
          return [ scoped, FAIL_SEARCH_MESSAGE ]
        end
      else
        return [ scoped, NOTHING_ENTERED_MESSAGE ]
      end
    end
    
    def build_message(count)
      "Našli smo #{count} #{ case count; when 1 : "sestavino"; when 2 : "sestavini"; when 3..4 : "sestavine"; else "sestavin"; end }."
    end
     
    def jsonized_all
      select('distinct id, name') #.collect { |i| {:id => i.id, :name => i.name } }
    end
  end #class << self
  
  def price_per_gram
    price_for_weight_in_grams / weight_in_grams
  end
  
  def to_s
    name
  end
  
end
