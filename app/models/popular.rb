class Popular < Impression
  
  class << self
    
    def five_recipe_ids_ordered_by_pageviews
      self.select("impressionable_id").where(:impressionable_type => "Recipe").group("impressionable_id").order("COUNT(impressionable_id) DESC").limit(5)
    end
    
    def recipes
      page_view_oredered_recipes = []
      for recipe_id in self.five_recipe_ids_ordered_by_pageviews.collect(&:impressionable_id)
        page_view_oredered_recipes << Recipe.find_by_id(recipe_id)
      end
      page_view_oredered_recipes
    end
    
  end #class << self
  
end