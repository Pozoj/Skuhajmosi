class RecipeInfo
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::NumberHelper
  
  delegate :pic, :photos_added?, :recipe_wines, :photos, :time_to_prepare, :time_to_cook, :num_people, :recipe_ingredients, :recipe_kinds, :origin, :number_of_kcal_per_meal, :calculated_price, :summary, :preparation, :suggestion, :to => :recipe
  
  def initialize(params)
    #@recipe = Recipe.approved.find_by_id(params[:id])
    @recipe = Recipe.find_by_id(params[:id])
  end     
  
  def recipe
    @recipe
  end
  
  # def authors_full_name
  #   author.full_name if author
  # end
  
  def author
    if recipe_source.present? and recipe_source.recipe_author.present? and recipe_source.recipe_source_kind.present?
      [recipe_source.recipe_author.full_name, recipe_source.recipe_source_kind.title].join(', ')
    end
  end
  
  def origin_added?
    origin.present?
  end
  
  def photos_url(size)
    pic.photo.url(size) if photos_added?
  end

  def wines_added?
    recipe_wines.any?
  end
  
  def wine
    recipe_wines.order(:id).last if wines_added? 
  end
  
  def wine_author
    recipe_wines.last.wine.author 
  end
  
  def photo
    pic
  end
  
  def preparation_time
    distance_of_time_in_words(time_to_prepare.minutes)
  end
  
  def cooking_time
    distance_of_time_in_words(time_to_cook.minutes)
  end
  
  def calories_per_meal
    "#{number_with_precision number_of_kcal_per_meal, :precision => 3} kcal/osebo"
  end
  
  def price
    number_to_currency(calculated_price, :precision => 2)
  end
end