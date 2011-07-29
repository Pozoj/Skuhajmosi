module RecipesHelper
  
  def recipe_kinds_link_list(recipe)
    association_link_list(recipe, "recipe_kinds")
  end
  
  def links_to_recipe_kinds(recipe) 
    list_items = recipe.recipe_kinds.collect do |recipe_kind|
      content_tag(:li, link_to(recipe_kind, recipe_kind)) 
    end.join.html_safe
    content_tag(:ul, list_items, :class => "recipe-kind-list")
  end
  
  def recipe_kinds_as_tags(recipe)
    tags = recipe.recipe_kinds.collect do |recipe_kind|
      link_to(recipe_kind, recipe_kind)
    end.join(", ").html_safe
  end
  
  def pdf_links_to_recipe_kinds(recipe) 
    recipe.recipe_kinds.collect do |recipe_kind|
      "<u><link href='#{recipe_kind_url}'>#{recipe_kind}</link></u>"
    end.join(', ').html_safe
  end
  
  def ingredients_text_list(recipe)
    recipe.recipe_ingredients.collect do |recipe_ingredient|
      recipe_ingredient.to_s
    end.join(', ')
  end
end
