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
  
  def ingredient_list(recipe)
    ingredient_list_items = recipe.recipe_ingredients.collect do |recipe_ingredient|
      ingredient_photo = []
      ingredient, quantity_unit = recipe_ingredient.info
      ingredient_photo << link_to(ingredient, recipe_recipe_ingredient_path(recipe.id, recipe_ingredient.id) )
      ingredient_photo << quantity_unit
      #ingredient_photo << link_to(image_tag(recipe_ingredient.ingredient.photos.first.photo.url(:super_small)), recipe_recipe_ingredient_path(recipe.id, recipe_ingredient.id) ) if recipe_ingredient.ingredient.photos.any?
      content_tag(:li, ingredient_photo.to_s.html_safe) 
    end.join.html_safe
    content_tag(:ul, ingredient_list_items, :class => "ingredient-list")
  end
  
  def ingredients_text_list(recipe)
    recipe.recipe_ingredients.collect do |recipe_ingredient|
      recipe_ingredient.to_s
    end.join(', ')
  end
end
